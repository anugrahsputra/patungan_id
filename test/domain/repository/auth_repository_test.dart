import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:patungan_id/app/core/core.dart';
import 'package:patungan_id/app/data/data.dart';
import 'package:patungan_id/app/data/repository/auth_repository_impl.dart';
import 'package:patungan_id/app/domain/domain.dart';

import '../../helper/mock.mocks.dart';

void main() {
  late AuthRepository authRepository;
  late MockAuthProvider mockAuthProvider;

  setUp(() {
    mockAuthProvider = MockAuthProvider();
    authRepository = AuthRepositoryImpl(mockAuthProvider);
  });

  group("getCurrentId", () {
    test('should return the current user id', () async {
      const userId = '123';
      when(mockAuthProvider.getCurrentId()).thenAnswer((_) async => userId);

      final result = await authRepository.getCurrentId();

      expect(result, equals(const Right(userId)));
      verify(mockAuthProvider.getCurrentId());
      verifyNoMoreInteractions(mockAuthProvider);
    });

    test('should return a ServerFailure when an exception is thrown', () async {
      final exception = FirebaseAuthException(code: 'code', message: 'message');
      when(mockAuthProvider.getCurrentId()).thenThrow(exception);

      final result = await authRepository.getCurrentId();

      expect(result, equals(Left(ServerFailure(exception.message!))));
      verify(mockAuthProvider.getCurrentId());
      verifyNoMoreInteractions(mockAuthProvider);
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
      when(mockAuthProvider.getCurrentUser()).thenAnswer((_) async => user);

      final result = await authRepository.getCurrentUser();

      expect(result, equals(const Right(user)));
      verify(mockAuthProvider.getCurrentUser());
      verifyNoMoreInteractions(mockAuthProvider);
    });

    test('should return a ServerFailure when an exception is throws', () async {
      final exception = FirebaseAuthException(code: 'code', message: 'message');
      when(mockAuthProvider.getCurrentUser()).thenThrow(exception);

      final result = await authRepository.getCurrentUser();

      expect(result, equals(Left(ServerFailure(exception.message!))));
      verify(mockAuthProvider.getCurrentUser());
      verifyNoMoreInteractions(mockAuthProvider);
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

      when(mockAuthProvider.getUserById(any)).thenAnswer((_) => stream);

      final result = authRepository.getUserById(uid);
      expect(result, equals(stream));
      verify(mockAuthProvider.getUserById(any));
      verifyNoMoreInteractions(mockAuthProvider);
    });
  });

  group("saveDataToDatabase", () {
    test('should save data to the database', () async {
      const name = 'Tajul';

      when(mockAuthProvider.saveDataToDatabase(any)).thenAnswer((_) async {});

      final result = await authRepository.saveDataToDatabase(name);

      expect(result, equals(const Right(null)));
    });

    test('should return a ServerFailure', () async {
      const name = 'Tajul';
      final exception = FirebaseAuthException(code: 'code', message: 'message');
      when(mockAuthProvider.saveDataToDatabase(any)).thenThrow(exception);

      final result = await authRepository.saveDataToDatabase(name);

      expect(result, equals(Left(ServerFailure(exception.message!))));
    });
  });

  group("signInWithPhoneNumber", () {
    test('should sign in in with phone number', () async {
      const phoneNumber = '+1234567890';
      when(mockAuthProvider.signInWithPhoneNumber(phoneNumber))
          .thenAnswer((_) async {});

      final result = await authRepository.signInWithPhoneNumber(phoneNumber);

      expect(result, equals(const Right(null)));
      verify(mockAuthProvider.signInWithPhoneNumber(phoneNumber));
      verifyNoMoreInteractions(mockAuthProvider);
    });

    test('should retrun a ServerFailure when an exception is thrown', () async {
      const phoneNumber = '+1234567890';
      final exception = FirebaseAuthException(code: 'code', message: 'message');
      when(mockAuthProvider.signInWithPhoneNumber(phoneNumber))
          .thenThrow(exception);

      final result = await authRepository.signInWithPhoneNumber(phoneNumber);

      expect(result, equals(Left(ServerFailure(exception.message!))));
      verify(mockAuthProvider.signInWithPhoneNumber(phoneNumber));
      verifyNoMoreInteractions(mockAuthProvider);
    });
  });

  group("signOut", () {
    test('should sign out', () async {
      when(mockAuthProvider.signOut()).thenAnswer((_) async {});

      final result = await authRepository.signOut();

      expect(result, equals(const Right(null)));
      verify(mockAuthProvider.signOut());
      verifyNoMoreInteractions(mockAuthProvider);
    });

    test('should retrun a ServerFailure when an exception is thrown', () async {
      final exception = FirebaseAuthException(code: 'code', message: 'message');
      when(mockAuthProvider.signOut()).thenThrow(exception);

      final result = await authRepository.signOut();

      expect(result, equals(Left(ServerFailure(exception.message!))));
      verify(mockAuthProvider.signOut());
      verifyNoMoreInteractions(mockAuthProvider);
    });
  });

  group('verifyOtp', () {
    test('should verify OTP', () async {
      const otp = '123456';
      when(mockAuthProvider.verifyOtp(otp)).thenAnswer((_) async {});

      final result = await authRepository.verifyOtp(otp);

      expect(result, equals(const Right(null)));
      verify(mockAuthProvider.verifyOtp(otp));
      verifyNoMoreInteractions(mockAuthProvider);
    });

    test('should return a ServerFailure when an exception is thrown', () async {
      const otp = '123456';
      final exception = FirebaseAuthException(code: 'code', message: 'message');
      when(mockAuthProvider.verifyOtp(otp)).thenThrow(exception);

      final result = await authRepository.verifyOtp(otp);

      expect(result, equals(Left(ServerFailure(exception.message!))));
      verify(mockAuthProvider.verifyOtp(otp));
      verifyNoMoreInteractions(mockAuthProvider);
    });
  });
}
