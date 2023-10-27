import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:patungan_id/app/core/core.dart';
import 'package:patungan_id/app/domain/domain.dart';

import '../../../helper/mock.mocks.dart';

void main() {
  late MockAuthRepository mockRepository;
  late ResendOtpUsecase usecase;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = ResendOtpUsecase(mockRepository);
  });

  const tPhoneNumber = '6281234567890';

  test("should save name to database", () async {
    when(mockRepository.resendOtp(any))
        .thenAnswer((_) async => const Right(null));

    final result = await usecase.call(tPhoneNumber);

    expect(result, const Right(null));
    verify(mockRepository.resendOtp(tPhoneNumber));
    verifyNoMoreInteractions(mockRepository);
  });

  test(
    "should return failure when save to database fails",
    () async {
      final exception = FirebaseAuthException(code: 'code', message: 'message');
      when(mockRepository.resendOtp(any))
          .thenAnswer((_) async => Left(ServerFailure(exception.message!)));

      final result = await usecase.call(tPhoneNumber);

      expect(result, Left(ServerFailure(exception.message!)));
      verify(mockRepository.resendOtp(tPhoneNumber));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
