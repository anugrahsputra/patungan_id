import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppSettings {
  void changeThemeMode(ThemeMode themeMode);
  bool isDarkMode();
}

class AppSettingsImpl implements AppSettings {
  @override
  void changeThemeMode(ThemeMode themeMode) => Get.changeThemeMode(themeMode);

  @override
  bool isDarkMode() {
    return Get.isDarkMode;
  }
}
