import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:patungan_id/app/core/core.dart';
import 'package:patungan_id/app/domain/usecase/setting/change_theme_mode_usecase.dart';

import '../../../helper/mock.mocks.dart';

void main() {
  late AppSettingsUsecase usecase;
  late MockSettingRepository mockSettingRepository;

  setUp(() {
    mockSettingRepository = MockSettingRepository();
    usecase = AppSettingsUsecase(settingRepository: mockSettingRepository);
  });

  const tThemeMode = ThemeMode.dark;

  test('should change the theme mode', () async {
    when(mockSettingRepository.changeThemeMode(any))
        .thenAnswer((_) async => const Right(null));

    final result = await usecase(tThemeMode);

    expect(result, const Right(null));
    verify(mockSettingRepository.changeThemeMode(tThemeMode));
    verifyNoMoreInteractions(mockSettingRepository);
  });

  test('should return a failure when changing the theme mode fails', () async {
    const exception = CachedException('', message: 'message');
    when(mockSettingRepository.changeThemeMode(any))
        .thenAnswer((_) async => Left(CachedFailure(exception.message)));

    final result = await usecase(tThemeMode);

    expect(result, Left(CachedFailure(exception.message)));
    verify(mockSettingRepository.changeThemeMode(tThemeMode));
    verifyNoMoreInteractions(mockSettingRepository);
  });
}
