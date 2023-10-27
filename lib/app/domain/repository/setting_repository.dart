import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';

abstract class SettingRepository {
  ThemeMode getLocalThemeMode();

  Future<Either<Failure, void>> changeThemeMode(ThemeMode themeMode);
}
