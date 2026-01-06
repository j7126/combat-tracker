import 'dart:io';

import 'package:combat_tracker/datamodel/campaign.pb.dart';
import 'package:combat_tracker/datamodel/campaign_file.pb.dart';
import 'package:combat_tracker/datamodel/extension/timestamp_extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:macos_secure_bookmarks/macos_secure_bookmarks.dart';
import 'package:path/path.dart';
import 'package:window_manager/window_manager.dart';

class CampaignManager {
  static const String campaignFileExtension = "campaign";

  static late CampaignManager instance;

  bool get isOpen => campaign != null && file != null;
  Campaign? campaign;
  File? file;

  Future saveCampaign() async {
    if (!isOpen) {
      return;
    }
    await file!.writeAsBytes(campaign!.writeToBuffer());
  }

  Future closeCampaign() async {
    await saveCampaign();
    file = null;
    campaign = null;
    await windowManager.setTitle("Combat Tracker");
  }

  Future<CampaignFile?> createCampaign() async {
    closeCampaign();

    String? filePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Create New Campaign',
      type: FileType.custom,
      allowedExtensions: [campaignFileExtension],
    );

    if (filePath == null) {
      return null;
    }

    if (extension(filePath) != ".$campaignFileExtension") {
      filePath = "$filePath.$campaignFileExtension";
    }

    file = File(filePath);
    campaign = Campaign(combats: [], characters: [], createdTimestamp: TimestampExtension.now());
    await file!.writeAsBytes(campaign!.writeToBuffer());
    var campaignFile = CampaignFile(path: file!.path);
    if (Platform.isMacOS) {
      campaignFile.macosBookmark = await SecureBookmarks().bookmark(file!);
    }
    _campaignOpened();
    return campaignFile;
  }

  Future<CampaignFile?> openCampaign({CampaignFile? campaignFile}) async {
    closeCampaign();

    if (campaignFile == null) {
      var result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.custom, allowedExtensions: [campaignFileExtension]);
      if (result != null && result.files.length == 1) {
        campaignFile = CampaignFile(path: result.files.single.path);
      }
    }
    if (campaignFile != null) {
      File? file;
      if (Platform.isMacOS) {
        if (campaignFile.macosBookmark.isNotEmpty) {
          var entity = await SecureBookmarks().resolveBookmark(campaignFile.macosBookmark);
          if (entity is File) {
            file = entity;
            await SecureBookmarks().startAccessingSecurityScopedResource(file);
          }
        } else {
          file = File(campaignFile.path);
          campaignFile.macosBookmark = await SecureBookmarks().bookmark(file);
        }
      } else {
        file = File(campaignFile.path);
      }
      if (file != null) {
        if (await file.exists() && !file.path.contains("/.Trash/")) {
          campaignFile.path = file.path;
          var data = await file.readAsBytes();
          try {
            campaign = Campaign.fromBuffer(data);
            this.file = file;
          } catch (e) {
            campaign = null;
            this.file = null;
            campaignFile = null;
          }
        } else {
          campaignFile = null;
          if (Platform.isMacOS) {
            SecureBookmarks().stopAccessingSecurityScopedResource(file);
          }
        }
      }
    }
    _campaignOpened();
    return campaignFile;
  }

  void _campaignOpened() async {
    if (isOpen) {
      await windowManager.setTitle("Combat Tracker: ${basenameWithoutExtension(file!.path)}");
    }
  }
}
