import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:patungan_id/app/core/core.dart';
import 'package:patungan_id/app/presentation/presentation.dart';

import '../../helper/mock.mocks.dart';

void main() {
  late MockSignInUsecase mockSignInUsecase;
  late MockVerifyOtpUsecase mockVerifyOtpUsecase;
  late MockSignOutUsecase mockSignOutUsecase;
  late MockGetCurrentUserUsecase mockGetCurrentUserUsecase;
  late MockGetCachedUserUsecase mockGetCachedUserUsecase;
  late MockSaveToDatabaseUsecase mockSaveToDatabaseUsecase;
  late MockGetUserByIdUsecase mockGetUserByIdUsecase;
  late MockGetCurrentIdUsecase mockGetCurrentIdUsecase;
  late MockResendOtpUsecase mockResendOtpUsecase;
  late AuthCubit authCubit;

  setUp(() {
    mockSignInUsecase = MockSignInUsecase();
    mockVerifyOtpUsecase = MockVerifyOtpUsecase();
    mockSignOutUsecase = MockSignOutUsecase();
    mockGetCurrentUserUsecase = MockGetCurrentUserUsecase();
    mockGetCachedUserUsecase = MockGetCachedUserUsecase();
    mockSaveToDatabaseUsecase = MockSaveToDatabaseUsecase();
    mockGetUserByIdUsecase = MockGetUserByIdUsecase();
    mockGetCurrentIdUsecase = MockGetCurrentIdUsecase();
    mockResendOtpUsecase = MockResendOtpUsecase();
    authCubit = AuthCubit(
      mockSignInUsecase,
      mockVerifyOtpUsecase,
      mockSignOutUsecase,
      mockGetCurrentUserUsecase,
      mockGetCachedUserUsecase,
      mockSaveToDatabaseUsecase,
      mockGetUserByIdUsecase,
      mockGetCurrentIdUsecase,
      mockResendOtpUsecase,
    );
  });

  group('AuthCubit', () {
    const tPhoneNumber = '1234567890';
    const tOtp = '123456';
    const tName = 'John Doe';
    const tUid = 'uid';

    blocTest<AuthCubit, AuthState>(
      'emits [loading, success] when signIn is successful',
      build: () {
        when(mockSignInUsecase.call(tPhoneNumber))
            .thenAnswer((_) async => const Right(null));
        return authCubit;
      },
      act: (cubit) => cubit.signIn(phoneNumber: tPhoneNumber),
      expect: () => const <AuthState>[
        AuthState.loading(),
        AuthState.success(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when signIn fails',
      build: () {
        when(mockSignInUsecase.call(tPhoneNumber)).thenAnswer(
            (_) async => const Left(ServerFailure('Failed to sign in')));
        return authCubit;
      },
      act: (cubit) => cubit.signIn(phoneNumber: tPhoneNumber),
      expect: () => const <AuthState>[
        AuthState.loading(),
        AuthState.error('Failed to sign in'),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, otpResent] when resendOtp is successful',
      build: () {
        when(mockResendOtpUsecase.call(tPhoneNumber))
            .thenAnswer((_) async => const Right(null));
        return authCubit;
      },
      act: (cubit) => cubit.resendOtp(phoneNumber: tPhoneNumber),
      expect: () => const <AuthState>[
        AuthState.loading(),
        AuthState.otpResent(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when resendOtp fails',
      build: () {
        when(mockResendOtpUsecase.call(tPhoneNumber)).thenAnswer(
            (_) async => const Left(ServerFailure('Failed to resend OTP')));
        return authCubit;
      },
      act: (cubit) => cubit.resendOtp(phoneNumber: tPhoneNumber),
      expect: () => const <AuthState>[
        AuthState.loading(),
        AuthState.error('Failed to resend OTP'),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, success] when verifyOtp is successful',
      build: () {
        when(mockVerifyOtpUsecase.call(tOtp))
            .thenAnswer((_) async => const Right(null));
        return authCubit;
      },
      act: (cubit) => cubit.verifyOtp(otp: tOtp),
      expect: () => const <AuthState>[
        AuthState.loading(),
        AuthState.success(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when verifyOtp fails',
      build: () {
        when(mockVerifyOtpUsecase.call(tOtp)).thenAnswer(
            (_) async => const Left(ServerFailure('Failed to verify OTP')));
        return authCubit;
      },
      act: (cubit) => cubit.verifyOtp(otp: tOtp),
      expect: () => const <AuthState>[
        AuthState.loading(),
        AuthState.error('Failed to verify OTP'),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, success] when signOut is successful',
      build: () {
        when(mockSignOutUsecase.call())
            .thenAnswer((_) async => const Right(null));
        return authCubit;
      },
      act: (cubit) => cubit.signOUt(),
      expect: () => const <AuthState>[
        AuthState.loading(),
        AuthState.success(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when signOut fails',
      build: () {
        when(mockSignOutUsecase.call()).thenAnswer(
            (_) async => const Left(ServerFailure('Failed to sign out')));
        return authCubit;
      },
      act: (cubit) => cubit.signOUt(),
      expect: () => const <AuthState>[
        AuthState.loading(),
        AuthState.error('Failed to sign out'),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, success] when saveToDatabase is successful',
      build: () {
        when(mockSaveToDatabaseUsecase.call(tName))
            .thenAnswer((_) async => const Right(null));
        return authCubit;
      },
      act: (cubit) => cubit.saveToDatabase(name: tName),
      expect: () => const <AuthState>[
        AuthState.loading(),
        AuthState.success(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when saveToDatabase fails',
      build: () {
        when(mockSaveToDatabaseUsecase.call(tName)).thenAnswer((_) async =>
            const Left(ServerFailure('Failed to save to database')));
        return authCubit;
      },
      act: (cubit) => cubit.saveToDatabase(name: tName),
      expect: () => const <AuthState>[
        AuthState.loading(),
        AuthState.error('Failed to save to database'),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [success] when getCachedCurrentId is successful',
      build: () {
        when(mockGetCachedUserUsecase.call())
            .thenAnswer((_) async => const Right(tUid));
        return authCubit;
      },
      act: (cubit) => cubit.getCachedCurrentId(),
      expect: () => const <AuthState>[
        AuthState.success(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [error] when getCachedCurrentId fails',
      build: () {
        when(mockGetCachedUserUsecase.call()).thenAnswer((_) async =>
            const Left(ServerFailure('Failed to get cached user')));
        return authCubit;
      },
      act: (cubit) => cubit.getCachedCurrentId(),
      expect: () => const <AuthState>[
        AuthState.error('Failed to get cached user'),
      ],
    );
  });
}
