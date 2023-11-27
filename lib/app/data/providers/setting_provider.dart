import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/core.dart';

abstract class SettingProvider {
  ThemeMode getLocalThemeMode();

  Future<void> changeThemeMode(ThemeMode themeMode);
}

class SettingProviderImpl implements SettingProvider {
  final SharedPreferences sharedPreferences;
  final AppSettings themes;

  SettingProviderImpl({
    required this.sharedPreferences,
    required this.themes,
  });

  String get themeModeKey => LocalStoragePath.themeMode;

  @override
  ThemeMode getLocalThemeMode() {
    String? themeMode = sharedPreferences.getString(themeModeKey);

    switch (themeMode) {
      case "dark":
        return ThemeMode.dark;
      case "light":
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Future<void> changeThemeMode(ThemeMode themeMode) async {
    themes.changeThemeMode(themeMode);

    bool isChanged = false;
    while (!isChanged) {
      if (themeMode == ThemeMode.dark) {
        await Future.delayed(const Duration(milliseconds: 100));

        isChanged = themes.isDarkMode() == true;
      } else if (themeMode == ThemeMode.light) {
        await Future.delayed(const Duration(milliseconds: 100));

        isChanged = themes.isDarkMode() == false;
      } else {
        await Future.delayed(const Duration(milliseconds: 500));

        isChanged = themes.isDarkMode() == true;
      }
    }

    await sharedPreferences.setString(themeModeKey, themeMode.name);
  }
}
