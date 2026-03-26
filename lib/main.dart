import 'dart:io';

import 'package:combat_tracker/campaign/campaign_manager.dart';
import 'package:combat_tracker/settings/settings.dart';
import 'package:combat_tracker/startup_page.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:xdg_desktop_portal/xdg_desktop_portal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await windowManager.setTitle("Combat Tracker");
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool settingsReady = false;
  bool get ready => settingsReady;
  Color? overrideAcentColor;

  void loadSettingsService() async {
    await SettingsService.build();
    CampaignManager.instance = CampaignManager();
    setState(() {
      settingsReady = true;
    });
  }

  void getAccentColor() async {
    if (Platform.isLinux) {
      try {
        var client = XdgDesktopPortalClient();
        var result = await client.settings.read(
          "org.freedesktop.appearance",
          "accent-color",
        );
        var vals = List.from(
          result.asVariant().asStruct().map((x) => x.asDouble()),
        );
        if (vals.length == 3 && !vals.any((x) => x < 0 || x > 1)) {
          var color = Color.fromARGB(
            255,
            (255 * vals[0]).floor(),
            (255 * vals[1]).floor(),
            (255 * vals[2]).floor(),
          );
          if (mounted) {
            setState(() {
              overrideAcentColor = color;
            });
          }
        }
      } catch (exception) {
        overrideAcentColor = null;
      }
    }
  }

  @override
  void initState() {
    loadSettingsService();
    getAccentColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        if (overrideAcentColor != null) {
          lightDynamic = ColorScheme.fromSeed(
            seedColor: overrideAcentColor!,
            brightness: Brightness.light,
          );
          darkDynamic = ColorScheme.fromSeed(
            seedColor: overrideAcentColor!,
            brightness: Brightness.dark,
          );
        }
        return MaterialApp(
          title: "Combat Tracker",
          theme: ThemeData(colorScheme: lightDynamic, useMaterial3: true),
          darkTheme: ThemeData(colorScheme: darkDynamic, useMaterial3: true),
          home: ready
              ? StartupPage()
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
