import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:patungan_id/app/domain/domain.dart';

import '../../../helper/mock.mocks.dart';

void main() {
  late GetLocalThemeModeUsecase usecase;
  late MockSettingRepository mockSettingRepository;

  setUp(() {
    mockSettingRepository = MockSettingRepository();
    usecase =
        GetLocalThemeModeUsecase(settingRepository: mockSettingRepository);
  });

  const tThemeMode = ThemeMode.dark;

  test('should return the local theme mode', () async {
    when(mockSettingRepository.getLocalThemeMode()).thenReturn(tThemeMode);

    final result = usecase();

    expect(result, tThemeMode);
    verify(mockSettingRepository.getLocalThemeMode());
    verifyNoMoreInteractions(mockSettingRepository);
  });
}
