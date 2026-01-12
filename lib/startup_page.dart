import 'dart:io';

import 'package:combat_tracker/about/about_page.dart';
import 'package:combat_tracker/campaign_manager.dart';
import 'package:combat_tracker/campaign/campaign_page.dart';
import 'package:combat_tracker/datamodel/campaign_file.pb.dart';
import 'package:combat_tracker/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:macos_secure_bookmarks/macos_secure_bookmarks.dart';
import 'package:path/path.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  List<CampaignFile>? recentFiles;

  @override
  void initState() {
    _checkCampaignFiles();
    super.initState();
  }

  void _checkCampaignFiles() async {
    List<CampaignFile> files = [];
    for (var data in SettingsService.instance.conf_recentFiles) {
      var recentFile = CampaignFile.fromJson(data);
      FileSystemEntity file;
      if (Platform.isMacOS) {
        try {
          file = await SecureBookmarks().resolveBookmark(
            recentFile.macosBookmark,
          );
        } on PlatformException {
          continue;
        }
        await SecureBookmarks().startAccessingSecurityScopedResource(file);
      } else {
        file = File(recentFile.path);
      }
      if (await file.exists() && !file.path.contains("/.Trash/")) {
        recentFile.path = file.path;
        files.add(recentFile);
      }
      if (Platform.isMacOS) {
        await SecureBookmarks().stopAccessingSecurityScopedResource(file);
      }
    }
    SettingsService.instance.conf_recentFiles = files
        .map((x) => x.writeToJson())
        .toList();
    setState(() {
      recentFiles = files;
    });
  }

  void _createCampaign() async {
    var campaignFile = await CampaignManager.instance.createCampaign();
    if (campaignFile == null) {
      return;
    }
    _campaignOpened(campaignFile);
  }

  void _openCampaign({CampaignFile? campaignFile}) async {
    campaignFile = await CampaignManager.instance.openCampaign(
      campaignFile: campaignFile,
    );
    if (campaignFile == null) {
      _checkCampaignFiles();
      if (mounted) {
        showDialog<void>(
          context: this.context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Failed to open file'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      return;
    }
    _campaignOpened(campaignFile);
  }

  void _campaignOpened(CampaignFile campaignFile) async {
    setState(() {
      recentFiles ??= [];
      recentFiles!.removeWhere((x) => x.path == campaignFile.path);
      recentFiles!.insert(0, campaignFile);
      SettingsService.instance.conf_recentFiles = recentFiles!
          .map((x) => x.writeToJson())
          .toList();
    });
    if (!mounted) {
      return;
    }
    await Navigator.of(
      this.context,
    ).push(MaterialPageRoute(builder: (ctx) => CampaignPage()));
    if (!mounted) {
      return;
    }
    _checkCampaignFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FilledButton(
            onPressed: _createCampaign,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.add), Text("Create Campaign")],
            ),
          ),
          Gap(8.0),
          FilledButton(
            onPressed: () => _openCampaign(),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                ColorScheme.of(context).tertiary,
              ),
              foregroundColor: WidgetStatePropertyAll(
                ColorScheme.of(context).onTertiary,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.file_open), Text("Open Campaign")],
            ),
          ),
          Gap(8.0),
          PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: const Text('About'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AboutPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          Gap(16.0),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            recentFiles == null
                ? CircularProgressIndicator()
                : recentFiles!.isEmpty
                ? Center(child: Text("You don't have any recent campaigns"))
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (var file in recentFiles!)
                            SizedBox(
                              width: double.infinity,
                              child: Card(
                                clipBehavior: Clip.hardEdge,
                                child: InkWell(
                                  onTap: () =>
                                      _openCampaign(campaignFile: file),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          basenameWithoutExtension(file.path),
                                          style: TextTheme.of(
                                            context,
                                          ).titleLarge,
                                        ),
                                        Text(
                                          file.path,
                                          style: TextTheme.of(context).bodySmall
                                              ?.copyWith(
                                                color: ColorScheme.of(
                                                  context,
                                                ).onSurface.withAlpha(100),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
