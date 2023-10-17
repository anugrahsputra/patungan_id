import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:patungan_id/app/domain/domain.dart';

import '../../helper/mock.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late VerifyOtpUsecase usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = VerifyOtpUsecase(mockAuthRepository);
  });

  test('should verify otp from the repository', () async {
    const otp = '123456';

    when(mockAuthRepository.verifyOtp(any))
        .thenAnswer((_) async => const Right(null));

    final result = await usecase.call(otp);

    expect(result, const Right(null));
  });
}
