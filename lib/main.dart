import 'package:combat_tracker/campaign/campaign_manager.dart';
import 'package:combat_tracker/settings/settings.dart';
import 'package:combat_tracker/startup_page.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

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

  void loadSettingsService() async {
    await SettingsService.build();
    CampaignManager.instance = CampaignManager();
    setState(() {
      settingsReady = true;
    });
  }

  @override
  void initState() {
    loadSettingsService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
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
