import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ChangeThemeMode {
  void changeThemeMode(ThemeMode themeMode);
  bool isDarkMode();
}

class ChangeThemeModeImpl implements ChangeThemeMode {
  @override
  void changeThemeMode(ThemeMode themeMode) => Get.changeThemeMode(themeMode);

  @override
  bool isDarkMode() {
    return Get.isDarkMode;
  }
}
