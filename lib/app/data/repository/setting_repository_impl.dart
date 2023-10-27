import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';
import '../data.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingProvider settingProvider;

  SettingRepositoryImpl({required this.settingProvider});

  @override
  Future<Either<Failure, void>> changeThemeMode(ThemeMode themeMode) async {
    try {
      final result = await settingProvider.changeThemeMode(themeMode);
      return Right(result);
    } on CachedException catch (e) {
      return Left(CachedFailure(e.message));
    }
  }

  @override
  ThemeMode getLocalThemeMode() {
    return settingProvider.getLocalThemeMode();
  }
}
