import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/core.dart';

part 'splash_cubit.freezed.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final FirebaseAuth auth;

  SplashCubit({required this.auth}) : super(const SplashState.initial());

  Future<void> fetch() async {
    final user = auth.currentUser;
    try {
      if (user == null) {
        emit(SplashState.loaded(null, tagetNextPage: AppPages.login));
      } else {
        emit(SplashState.loaded(user, tagetNextPage: AppPages.home));
      }
    } catch (e) {
      emit(SplashState.error(e.toString()));
    }
  }
}
