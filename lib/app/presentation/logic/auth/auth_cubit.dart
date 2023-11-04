import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import '../../../domain/domain.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUsecase signInUsecase;
  final VerifyOtpUsecase verifyOtpUsecase;
  final SignOutUsecase signOutUsecase;
  final GetCurrentUserUsecase currentUerUsecase;
  final GetCachedUserUsecase cachedUserUsecase;
  final SaveToDatabaseUsecase saveToDatabaseUsecase;
  final GetUserByIdUsecase userByIdUsecase;
  final GetCurrentIdUsecase currentUserIdUsecase;
  final ResendOtpUsecase resendOtpUsecase;

  UserEntity? userEntity;

  AuthCubit(
    this.signInUsecase,
    this.verifyOtpUsecase,
    this.signOutUsecase,
    this.currentUerUsecase,
    this.cachedUserUsecase,
    this.saveToDatabaseUsecase,
    this.userByIdUsecase,
    this.currentUserIdUsecase,
    this.resendOtpUsecase,
  ) : super(const AuthState.initial());

  static AuthCubit get(context) => BlocProvider.of(context);

  final Logger log = Logger("auth cubit");

  Future<void> signIn({required String phoneNumber}) async {
    emit(const AuthState.loading());
    final result = await signInUsecase.call(phoneNumber);
    result.fold(
      (l) => emit(AuthState.error(l.message)),
      (r) {
        emit(const AuthState.success());
      },
    );
  }

  Future<void> resendOtp({required String phoneNumber}) async {
    emit(const AuthState.loading());
    final result = await resendOtpUsecase.call(phoneNumber);
    result.fold((l) => emit(AuthState.error(l.message)),
        (r) => emit(const AuthState.otpResent()));
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

  Future<void> saveToDatabase({required String name}) async {
    emit(const AuthState.loading());
    final result = await saveToDatabaseUsecase.call(name);
    result.fold((l) => emit(AuthState.error(l.message)),
        (r) => emit(const AuthState.success()));
  }

  Future<void> getCachedCurrentId() async {
    final result = await cachedUserUsecase.call();
    result.fold((l) => emit(AuthState.error(l.message)),
        (r) => emit(const AuthState.success()));
  }

  Stream<UserEntity> getUserById(String uid) {
    return userByIdUsecase.call(uid);
  }
}
