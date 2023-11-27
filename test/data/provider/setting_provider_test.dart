import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:patungan_id/app/core/core.dart';
import 'package:patungan_id/app/data/data.dart';

import '../../helper/mock.mocks.dart';

void main() {
  late MockSharedPreferences mockSharedPref;
  late MockAppSettings mockAppSettings;
  late SettingProvider settingProvider;

  setUp(() {
    mockSharedPref = MockSharedPreferences();
    mockAppSettings = MockAppSettings();
    settingProvider = SettingProviderImpl(
        sharedPreferences: mockSharedPref, themes: mockAppSettings);
  });

  group("getLocalThemeMode", () {
    test("should return ThemeMode.system when no theme mode is set", () {
      when(mockSharedPref.getString(any)).thenReturn(null);

      final result = settingProvider.getLocalThemeMode();

      expect(result, ThemeMode.system);
      verify(mockSharedPref.getString(LocalStoragePath.themeMode));
      verifyNoMoreInteractions(mockSharedPref);
    });
    test('should return ThemeMode.dark when "dark" is set', () {
      when(mockSharedPref.getString(any)).thenReturn('dark');

      final result = settingProvider.getLocalThemeMode();

      expect(result, ThemeMode.dark);
      verify(mockSharedPref.getString(LocalStoragePath.themeMode));
      verifyNoMoreInteractions(mockSharedPref);
    });

    test('should return ThemeMode.light when "light" is set', () {
      when(mockSharedPref.getString(any)).thenReturn('light');

      final result = settingProvider.getLocalThemeMode();

      expect(result, ThemeMode.light);
      verify(mockSharedPref.getString(LocalStoragePath.themeMode));
      verifyNoMoreInteractions(mockSharedPref);
    });
  });

  group('changeThemeMode', () {
    test('should change theme mode to dark', () async {
      when(mockAppSettings.isDarkMode()).thenReturn(true);

      await settingProvider.changeThemeMode(ThemeMode.dark);

      verify(mockAppSettings.changeThemeMode(ThemeMode.dark));
      verify(mockAppSettings.isDarkMode());
      verify(mockSharedPref.setString(
          LocalStoragePath.themeMode, ThemeMode.dark.name));
      verifyNoMoreInteractions(mockAppSettings);
      verifyNoMoreInteractions(mockSharedPref);
    });

    test('should change theme mode to light', () async {
      when(mockAppSettings.isDarkMode()).thenReturn(false);

      await settingProvider.changeThemeMode(ThemeMode.light);

      verify(mockAppSettings.changeThemeMode(ThemeMode.light));
      verify(mockAppSettings.isDarkMode());
      verify(mockSharedPref.setString(
          LocalStoragePath.themeMode, ThemeMode.light.name));
      verifyNoMoreInteractions(mockAppSettings);
      verifyNoMoreInteractions(mockSharedPref);
    });

    test('should change theme mode to system', () async {
      when(mockAppSettings.isDarkMode()).thenReturn(true);

      await settingProvider.changeThemeMode(ThemeMode.system);

      verify(mockAppSettings.changeThemeMode(ThemeMode.system));
      verify(mockAppSettings.isDarkMode());
      verify(mockSharedPref.setString(
          LocalStoragePath.themeMode, ThemeMode.system.name));
      verifyNoMoreInteractions(mockAppSettings);
      verifyNoMoreInteractions(mockSharedPref);
    });
  });
}
