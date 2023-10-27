import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class ChangeThemeModeUsecase {
  final SettingRepository settingRepository;

  ChangeThemeModeUsecase({required this.settingRepository});

  Future<Either<Failure, void>> call(ThemeMode themeMode) async {
    return await settingRepository.changeThemeMode(themeMode);
  }
}
