import 'dart:async';
import 'dart:io';

import 'package:combat_tracker/datamodel/generated/campaign.pb.dart';
import 'package:combat_tracker/datamodel/generated/campaign_file.pb.dart';
import 'package:combat_tracker/datamodel/extension/campaign_extension.dart';
import 'package:combat_tracker/datamodel/extension/timestamp_extension.dart';
import 'package:combat_tracker/campaign/file_format.dart';
import 'package:file_picker/file_picker.dart';
import 'package:macos_secure_bookmarks/macos_secure_bookmarks.dart';
import 'package:path/path.dart';
import 'package:window_manager/window_manager.dart';
import 'package:xdg_desktop_portal/xdg_desktop_portal.dart';
import 'package:xxh3/xxh3.dart';

class CampaignManager {
  static const String campaignFileExtension = "campaign";

  static late CampaignManager instance;

  bool get isOpen => campaign != null && file != null;
  Campaign? campaign;
  File? file;
  int lastFileHash = 0;

  late Timer autoSaveTimer;

  CampaignManager() {
    autoSaveTimer = Timer(Duration(milliseconds: 60000), autosaveCallback);
  }

  void autosaveCallback() {
    if (isOpen) {
      saveCampaign();
    }
  }

  Future saveCampaign() async {
    if (!isOpen) {
      return;
    }
    var buffer = campaign!.writeToBuffer();
    var bufferHash = xxh3(buffer);
    if (bufferHash == lastFileHash) {
      return;
    }
    lastFileHash = bufferHash;
    await CampaignFileFormat.writeFile(file: file!, protobufPayload: buffer);
  }

  Future closeCampaign() async {
    await saveCampaign();
    file = null;
    campaign = null;
    await windowManager.setTitle("Combat Tracker");
  }

  Future<CampaignFile?> createCampaign() async {
    await closeCampaign();

    String? filePath;
    if (Platform.isLinux) {
      try {
        var client = XdgDesktopPortalClient();
        var result = await client.fileChooser
            .saveFile(
              title: 'Create New Campaign',
              filters: [
                XdgFileChooserFilter('Combat Tracker Campaign File', [
                  XdgFileChooserGlobPattern('*.$campaignFileExtension'),
                ]),
              ],
            )
            .first;
        filePath = result.uris.firstOrNull;
        if (filePath != null) {
          filePath = Uri.parse(filePath).toFilePath();
        }
        await client.close();
      } on XdgPortalRequestCancelledException {
        filePath = null;
      }
    } else {
      filePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Create New Campaign',
        type: FileType.custom,
        allowedExtensions: [campaignFileExtension],
      );
    }

    if (filePath == null) {
      return null;
    }

    if (extension(filePath) != ".$campaignFileExtension") {
      filePath = "$filePath.$campaignFileExtension";
    }

    file = File(filePath);
    campaign = Campaign(
      combats: [],
      characters: [],
      createdTimestamp: TimestampExtension.now(),
    );
    var buffer = campaign!.writeToBuffer();
    var bufferHash = xxh3(buffer);
    lastFileHash = bufferHash;
    await CampaignFileFormat.writeFile(file: file!, protobufPayload: buffer);
    var campaignFile = CampaignFile(path: file!.path);
    if (Platform.isMacOS) {
      campaignFile.macosBookmark = await SecureBookmarks().bookmark(file!);
    }
    _campaignOpened();
    return campaignFile;
  }

  Future<CampaignFile?> openCampaign({CampaignFile? campaignFile}) async {
    await closeCampaign();

    if (campaignFile == null) {
      if (Platform.isLinux) {
        try {
          var client = XdgDesktopPortalClient();
          var result = await client.fileChooser
              .openFile(
                title: "Open Campaign",
                filters: [
                  XdgFileChooserFilter('Combat Tracker Campaign File', [
                    XdgFileChooserGlobPattern('*.$campaignFileExtension'),
                  ]),
                ],
              )
              .first;
          var filePath = result.uris.firstOrNull;
          if (filePath != null) {
            filePath = Uri.parse(filePath).toFilePath();
            campaignFile = CampaignFile(path: filePath);
          }
          await client.close();
        } on XdgPortalRequestCancelledException {
          campaignFile = null;
        }
      } else {
        var result = await FilePicker.platform.pickFiles(
          dialogTitle: "Open Campaign",
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: [campaignFileExtension],
        );
        if (result != null && result.files.length == 1) {
          campaignFile = CampaignFile(path: result.files.single.path);
        }
      }
    }
    if (campaignFile != null) {
      File? file;
      if (Platform.isMacOS) {
        if (campaignFile.macosBookmark.isNotEmpty) {
          var entity = await SecureBookmarks().resolveBookmark(
            campaignFile.macosBookmark,
          );
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
          try {
            var readResult = await CampaignFileFormat.readFile(file);
            var data = readResult.payload;
            var bufferHash = xxh3(data);
            lastFileHash = bufferHash;
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
      campaign!.validate();
      await windowManager.setTitle(
        "Combat Tracker: ${basenameWithoutExtension(file!.path)}",
      );
    }
  }
}
