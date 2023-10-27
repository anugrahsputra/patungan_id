import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:patungan_id/app/core/core.dart';
import 'package:patungan_id/app/domain/domain.dart';

import '../../../helper/mock.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late VerifyOtpUsecase usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = VerifyOtpUsecase(mockAuthRepository);
  });

  const otp = '123456';

  test('should verify otp from the repository', () async {
    const otp = '123456';

    when(mockAuthRepository.verifyOtp(any))
        .thenAnswer((_) async => const Right(null));

    final result = await usecase.call(otp);

    expect(result, const Right(null));
    verify(mockAuthRepository.verifyOtp(otp));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return failure when verify otp fails', () async {
    final exception = FirebaseAuthException(code: 'code', message: 'message');
    when(mockAuthRepository.verifyOtp(any))
        .thenAnswer((_) async => Left(ServerFailure(exception.message!)));

    final result = await usecase.call(otp);

    expect(result, Left(ServerFailure(exception.message!)));
    verify(mockAuthRepository.verifyOtp(otp));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
