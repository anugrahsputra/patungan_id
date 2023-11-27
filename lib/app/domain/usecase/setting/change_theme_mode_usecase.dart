import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../domain.dart';

/// Use case for changing the theme mode of the app.
class AppSettingsUsecase {
  final SettingRepository settingRepository;

  AppSettingsUsecase({required this.settingRepository});

  /// Calls the [changeThemeMode] method of the [settingRepository] with the given [themeMode].
  /// Returns an [Either] object containing a [Failure] or [void].
  Future<Either<Failure, void>> call(ThemeMode themeMode) async {
    return await settingRepository.changeThemeMode(themeMode);
  }
}
