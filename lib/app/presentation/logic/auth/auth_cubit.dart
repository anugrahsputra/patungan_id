import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/domain.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUsecase signInUsecase;
  final VerifyOtpUsecase verifyOtpUsecase;
  final SignOutUsecase signOutUsecase;

  AuthCubit(
    this.signInUsecase,
    this.verifyOtpUsecase,
    this.signOutUsecase,
  ) : super(const AuthState.initial());

  static AuthCubit get(context) => BlocProvider.of(context);

  Future<void> signIn({required String phoneNumber}) async {
    emit(const AuthState.loading());
    final result = await signInUsecase.call(phoneNumber);
    result.fold(
      (l) => emit(AuthState.error(l.message)),
      (r) => emit(const AuthState.success()),
    );
  }

  Future<void> verifyOtp({required String otp}) async {
    emit(const AuthState.loading());
    final result = await verifyOtpUsecase.call(otp);
    result.fold((l) => emit(AuthState.error(l.message)),
        (r) => emit(const AuthState.success()));
  }

  Future<void> signOUt() async {
    emit(const AuthState.loading());
    final result = await signOutUsecase.call();
    result.fold((l) => emit(AuthState.error(l.message)),
        (r) => emit(const AuthState.success()));
  }
}
