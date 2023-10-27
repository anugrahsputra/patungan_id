part of 'setting_cubit.dart';

@freezed
class SettingState with _$SettingState {
  const factory SettingState.initial({required ThemeMode themeMode}) = _Initial;
  const factory SettingState.loading({required ThemeMode themeMode}) = _Loading;
  const factory SettingState.success({required ThemeMode themeMode}) = _Success;
  const factory SettingState.error({required String message}) = _Error;
}
