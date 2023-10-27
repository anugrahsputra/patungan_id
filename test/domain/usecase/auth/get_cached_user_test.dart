import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:patungan_id/app/core/core.dart';
import 'package:patungan_id/app/domain/domain.dart';

import '../../../helper/mock.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late GetCachedUserUsecase usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = GetCachedUserUsecase(mockAuthRepository);
  });

  const tuser = 'user';

  test('should get cached user from the repository', () async {
    when(mockAuthRepository.getCachedLocalCurrentUid())
        .thenAnswer((_) async => const Right(tuser));

    final result = await usecase.call();
    expect(result, const Right(tuser));
    verify(mockAuthRepository.getCachedLocalCurrentUid());
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return failure when get cached user fails', () async {
    final exception = FirebaseAuthException(code: 'code', message: 'message');
    when(mockAuthRepository.getCachedLocalCurrentUid())
        .thenAnswer((_) async => Left(ServerFailure(exception.message!)));

    final result = await usecase.call();

    expect(result, Left(ServerFailure(exception.message!)));
    verify(mockAuthRepository.getCachedLocalCurrentUid());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
