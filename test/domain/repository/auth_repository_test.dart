import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:patungan_id/app/core/core.dart';
import 'package:patungan_id/app/data/data.dart';
import 'package:patungan_id/app/domain/domain.dart';

import '../../helper/mock.mocks.dart';

void main() {
  late AuthRepository authRepository;
  late MockAuthenticationProvider mockAuthenticationProvider;

  setUp(() {
    mockAuthenticationProvider = MockAuthenticationProvider();
    authRepository = AuthRepositoryImpl(mockAuthenticationProvider);
  });

  const profilePic = 'profilepic';

  group("getCurrentId", () {
    test('should return the current user id', () async {
      const userId = '123';
      when(mockAuthenticationProvider.getCurrentId())
          .thenAnswer((_) async => userId);

      final result = await authRepository.getCurrentId();

      expect(result, equals(const Right(userId)));
      verify(mockAuthenticationProvider.getCurrentId());
      verifyNoMoreInteractions(mockAuthenticationProvider);
    });

    test('should return a ServerFailure when an exception is thrown', () async {
      final exception = FirebaseAuthException(code: 'code', message: 'message');
      when(mockAuthenticationProvider.getCurrentId()).thenThrow(exception);

      final result = await authRepository.getCurrentId();

      expect(result, equals(Left(ServerFailure(exception.message!))));
      verify(mockAuthenticationProvider.getCurrentId());
      verifyNoMoreInteractions(mockAuthenticationProvider);
    });
  });

  group("getCurrentUser", () {
    test('should return current user', () async {
      const user = UserModel(
        id: '123',
        name: 'Tajul',
        phoneNumber: '+1234567890',
        profilePic: 'profilepic',
        groupId: [],
        friendsId: [],
      );
      when(mockAuthenticationProvider.getCurrentUser())
          .thenAnswer((_) async => user);

      final result = await authRepository.getCurrentUser();

      expect(result, equals(const Right(user)));
      verify(mockAuthenticationProvider.getCurrentUser());
      verifyNoMoreInteractions(mockAuthenticationProvider);
    });

    test('should return a ServerFailure when an exception is throws', () async {
      final exception = FirebaseAuthException(code: 'code', message: 'message');
      when(mockAuthenticationProvider.getCurrentUser()).thenThrow(exception);

      final result = await authRepository.getCurrentUser();

      expect(result, equals(Left(ServerFailure(exception.message!))));
      verify(mockAuthenticationProvider.getCurrentUser());
      verifyNoMoreInteractions(mockAuthenticationProvider);
    });
  });

  group("getUserById", () {
    test('should return a stream of user entities', () {
      const uid = '123';
      final stream = Stream.value(
        const UserModel(
          id: '123',
          name: 'Tajul',
          phoneNumber: '+1234567890',
          profilePic: 'profilepic',
          groupId: [],
          friendsId: [],
        ),
      );

      when(mockAuthenticationProvider.getUserById(any))
          .thenAnswer((_) => stream);

      final result = authRepository.getUserById(uid);
      expect(result, equals(stream));
      verify(mockAuthenticationProvider.getUserById(any));
      verifyNoMoreInteractions(mockAuthenticationProvider);
    });
  });

  group("saveDataToDatabase", () {
    test('should save data to the database', () async {
      const name = 'Tajul';
      const profilePic = 'profilepic';
      when(mockAuthenticationProvider.saveDataToDatabase(any, any))
          .thenAnswer((_) async {});

      final result = await authRepository.saveDataToDatabase(name, profilePic);

      expect(result, equals(const Right(null)));
    });

    test('should return a ServerFailure', () async {
      const name = 'Tajul';
      final exception = FirebaseAuthException(code: 'code', message: 'message');
      when(mockAuthenticationProvider.saveDataToDatabase(any, any))
          .thenThrow(exception);

      final result = await authRepository.saveDataToDatabase(name, profilePic);

      expect(result, equals(Left(ServerFailure(exception.message!))));
    });
  });

  group("signInWithPhoneNumber", () {
    test('should sign in in with phone number', () async {
      const phoneNumber = '+1234567890';
      when(mockAuthenticationProvider.signInWithPhoneNumber(phoneNumber))
          .thenAnswer((_) async {});

      final result = await authRepository.signInWithPhoneNumber(phoneNumber);

      expect(result, equals(const Right(null)));
      verify(mockAuthenticationProvider.signInWithPhoneNumber(phoneNumber));
      verifyNoMoreInteractions(mockAuthenticationProvider);
    });

    test('should retrun a ServerFailure when an exception is thrown', () async {
      const phoneNumber = '+1234567890';
      final exception = FirebaseAuthException(code: 'code', message: 'message');
      when(mockAuthenticationProvider.signInWithPhoneNumber(phoneNumber))
          .thenThrow(exception);

      final result = await authRepository.signInWithPhoneNumber(phoneNumber);

      expect(result, equals(Left(ServerFailure(exception.message!))));
      verify(mockAuthenticationProvider.signInWithPhoneNumber(phoneNumber));
      verifyNoMoreInteractions(mockAuthenticationProvider);
    });
  });

  group("signOut", () {
    test('should sign out', () async {
      when(mockAuthenticationProvider.signOut()).thenAnswer((_) async {});

      final result = await authRepository.signOut();

      expect(result, equals(const Right(null)));
      verify(mockAuthenticationProvider.signOut());
      verifyNoMoreInteractions(mockAuthenticationProvider);
    });

    test('should retrun a ServerFailure when an exception is thrown', () async {
      final exception = FirebaseAuthException(code: 'code', message: 'message');
      when(mockAuthenticationProvider.signOut()).thenThrow(exception);

      final result = await authRepository.signOut();

      expect(result, equals(Left(ServerFailure(exception.message!))));
      verify(mockAuthenticationProvider.signOut());
      verifyNoMoreInteractions(mockAuthenticationProvider);
    });
  });

  group('verifyOtp', () {
    test('should verify OTP', () async {
      const otp = '123456';
      when(mockAuthenticationProvider.verifyOtp(otp)).thenAnswer((_) async {});

      final result = await authRepository.verifyOtp(otp);

      expect(result, equals(const Right(null)));
      verify(mockAuthenticationProvider.verifyOtp(otp));
      verifyNoMoreInteractions(mockAuthenticationProvider);
    });

    test('should return a ServerFailure when an exception is thrown', () async {
      const otp = '123456';
      final exception = FirebaseAuthException(code: 'code', message: 'message');
      when(mockAuthenticationProvider.verifyOtp(otp)).thenThrow(exception);

      final result = await authRepository.verifyOtp(otp);

      expect(result, equals(Left(ServerFailure(exception.message!))));
      verify(mockAuthenticationProvider.verifyOtp(otp));
      verifyNoMoreInteractions(mockAuthenticationProvider);
    });
  });

  group("getCachedUser", () {
    const cachedUid = '123456';
    test('should return cached uid from auth provider', () async {
      when(mockAuthenticationProvider.getUser()).thenReturn(cachedUid);

      final result = await authRepository.getCachedLocalCurrentUid();

      expect(result, const Right(cachedUid));
      verify(mockAuthenticationProvider.getUser());
      verifyNoMoreInteractions(mockAuthenticationProvider);
    });

    test('should return cached failure when cached exception is thrown',
        () async {
      const errorMessage = 'Error message';
      when(mockAuthenticationProvider.getUser()).thenThrow(
          const CachedException(errorMessage, message: errorMessage));

      final result = await authRepository.getCachedLocalCurrentUid();

      expect(result, const Left(CachedFailure(errorMessage)));
      verify(mockAuthenticationProvider.getUser());
      verifyNoMoreInteractions(mockAuthenticationProvider);
    });
  });

  group("resendOtp", () {
    const phoneNumber = '6281234567890';
    test("should return resend otp from auth provider", () async {
      when(mockAuthenticationProvider.resendOtp(any)).thenAnswer((_) async {});

      final result = await authRepository.resendOtp(phoneNumber);

      expect(result, equals(const Right(null)));
      verify(mockAuthenticationProvider.resendOtp(phoneNumber));
      verifyNoMoreInteractions(mockAuthenticationProvider);
    });

    test('should retrun a ServerFailure when an exception is thrown', () async {
      const phoneNumber = '+1234567890';
      final exception = FirebaseAuthException(code: 'code', message: 'message');
      when(mockAuthenticationProvider.resendOtp(phoneNumber))
          .thenThrow(exception);

      final result = await authRepository.resendOtp(phoneNumber);

      expect(result, equals(Left(ServerFailure(exception.message!))));
      verify(mockAuthenticationProvider.resendOtp(phoneNumber));
      verifyNoMoreInteractions(mockAuthenticationProvider);
    });
  });
}
