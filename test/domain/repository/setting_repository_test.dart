import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:patungan_id/app/core/core.dart';
import 'package:patungan_id/app/data/data.dart';
import 'package:patungan_id/app/domain/domain.dart';

import '../../helper/mock.mocks.dart';

void main() {
  late MockSettingProvider mockSettingProvider;
  late SettingRepository settingRepository;

  setUp(() {
    mockSettingProvider = MockSettingProvider();
    settingRepository =
        SettingRepositoryImpl(settingProvider: mockSettingProvider);
  });

  group("getLocalThemeMode", () {
    test("should return the local theme mode from the provider", () {
      const expectedThemeMode = ThemeMode.light;
      when(mockSettingProvider.getLocalThemeMode())
          .thenReturn(expectedThemeMode);

      final result = settingRepository.getLocalThemeMode();

      expect(result, expectedThemeMode);
      verify(mockSettingProvider.getLocalThemeMode());
      verifyNoMoreInteractions(mockSettingProvider);
    });
  });

  group('changeThemeMode', () {
    test('should return Right when the provider returns successfully',
        () async {
      const expectedThemeMode = ThemeMode.dark;
      when(mockSettingProvider.changeThemeMode(expectedThemeMode))
          .thenAnswer((_) async {});

      final result = await settingRepository.changeThemeMode(expectedThemeMode);

      expect(result, const Right(null));
      verify(mockSettingProvider.changeThemeMode(expectedThemeMode));
      verifyNoMoreInteractions(mockSettingProvider);
    });

    test('should return Left when the provider throws a CachedException',
        () async {
      const expectedThemeMode = ThemeMode.system;
      const exception = CachedException('error', message: 'message');
      when(mockSettingProvider.changeThemeMode(expectedThemeMode))
          .thenThrow(exception);

      final result = await settingRepository.changeThemeMode(expectedThemeMode);

      expect(result, Left(CachedFailure(exception.message)));
      verify(mockSettingProvider.changeThemeMode(expectedThemeMode));
      verifyNoMoreInteractions(mockSettingProvider);
    });
  });
}
