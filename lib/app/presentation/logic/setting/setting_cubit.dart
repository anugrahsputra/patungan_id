import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/domain.dart';

part 'setting_cubit.freezed.dart';
part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  final ChangeThemeModeUsecase themeModeUsecase;
  final GetLocalThemeModeUsecase getThemeModeUsecase;

  SettingCubit({
    required this.getThemeModeUsecase,
    required this.themeModeUsecase,
  }) : super(SettingState.initial(themeMode: getThemeModeUsecase.call()));

  void fetchSetting() async {
    emit(SettingState.success(themeMode: getThemeModeUsecase.call()));
  }

  void changeThemeMode(ThemeMode themeMode) async {
    final result = await themeModeUsecase.call(themeMode);
    result.fold((l) => emit(SettingState.error(message: l.message)), (r) {
      emit(SettingState.loading(themeMode: getThemeModeUsecase.call()));
      emit(SettingState.success(themeMode: getThemeModeUsecase.call()));
    });
  }
}
