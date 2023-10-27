import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:patungan_id/app/core/core.dart';
import 'package:patungan_id/app/domain/domain.dart';

import '../../../helper/mock.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late GetCurrentIdUsecase usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = GetCurrentIdUsecase(mockAuthRepository);
  });

  const tId = 'id';

  test('should get current id from the repository', () async {
    when(mockAuthRepository.getCurrentId())
        .thenAnswer((_) async => const Right(tId));

    final result = await usecase.call();
    expect(result, const Right(tId));
    verify(mockAuthRepository.getCurrentId());
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return failure when get current id fails', () async {
    final exception = FirebaseAuthException(code: 'code', message: 'message');
    when(mockAuthRepository.getCurrentId())
        .thenAnswer((_) async => Left(ServerFailure(exception.message!)));

    final result = await usecase.call();

    expect(result, Left(ServerFailure(exception.message!)));
    verify(mockAuthRepository.getCurrentId());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
