import 'package:flutter/material.dart';

import '../../domain.dart';

class GetLocalThemeModeUsecase {
  final SettingRepository settingRepository;

  GetLocalThemeModeUsecase({required this.settingRepository});

  ThemeMode call() {
    return settingRepository.getLocalThemeMode();
  }
}
