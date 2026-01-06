// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static late SettingsService instance;

  static Future build() async {
    instance = SettingsService();
    await instance._setup();
  }

  late SharedPreferences prefs;

  Future _setup() async {
    prefs = await SharedPreferences.getInstance();
    _readData();
  }

  void _readData() {
    var recentFiles = prefs.getStringList('recentFiles');
    if (recentFiles != null) {
      _conf_recentFiles = recentFiles;
    }
  }

  List<String> _conf_recentFiles = [];
  List<String> get conf_recentFiles => _conf_recentFiles;
  set conf_recentFiles(List<String> val) {
      _conf_recentFiles = val;
      prefs.setStringList('recentFiles', val);
  }
}
