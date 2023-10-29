import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';

part 'splash_cubit.freezed.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final FirebaseAuth auth;
  final GetCurrentUerUsecase currentUser;

  SplashCubit({
    required this.auth,
    required this.currentUser,
  }) : super(const SplashState.initial());

  Future<void> fetch() async {
    final user = auth.currentUser;
    try {
      if (user == null) {
        emit(SplashState.loaded(null, tagetNextPage: AppPages.login));
      } else {
        final result = await currentUser.call();
        result.fold(
          (l) => emit(
              SplashState.loaded(user, tagetNextPage: AppPages.setupProfile)),
          (r) => emit(SplashState.loaded(user, tagetNextPage: AppPages.home)),
        );
      }
    } catch (e) {
      emit(SplashState.error(e.toString()));
    }
  }
}
