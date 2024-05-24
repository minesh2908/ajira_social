import 'package:ajira_social/service/shared_pref.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = AppPrefHelper.getThemeMode();

  ThemeMode get themeMode => _themeMode;

  Future<void> changeTheme(ThemeMode themeMode) async {
    await AppPrefHelper.setThemeMode(mode: themeMode);
    _themeMode = themeMode;
    notifyListeners();
  }

  Future<void> getTheme() async {
    _themeMode = AppPrefHelper.getThemeMode();
    notifyListeners();
  }
}
