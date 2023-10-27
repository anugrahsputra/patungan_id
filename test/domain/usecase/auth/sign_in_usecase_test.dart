import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:patungan_id/app/core/core.dart';
import 'package:patungan_id/app/domain/domain.dart';

import '../../../helper/mock.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late SignInUsecase usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignInUsecase(mockAuthRepository);
  });

  const tPhoneNumber = '081234567890';

  test('should sign in with phone number from the repository', () async {
    when(mockAuthRepository.signInWithPhoneNumber(any))
        .thenAnswer((_) async => const Right(null));

    final result = await usecase.call(tPhoneNumber);
    expect(result, const Right(null));
    verify(mockAuthRepository.signInWithPhoneNumber(tPhoneNumber));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return failure when sign in with phone number fails', () async {
    final exception = FirebaseAuthException(code: 'code', message: 'message');
    when(mockAuthRepository.signInWithPhoneNumber(any))
        .thenAnswer((_) async => Left(ServerFailure(exception.message!)));

    final result = await usecase.call(tPhoneNumber);

    expect(result, Left(ServerFailure(exception.message!)));
    verify(mockAuthRepository.signInWithPhoneNumber(tPhoneNumber));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
