import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:patungan_id/app/core/core.dart';
import 'package:patungan_id/app/domain/usecase/user/user.dart';

import '../../../helper/mock.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late GetCurrentIdUsecase usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = GetCurrentIdUsecase(userRepository: mockUserRepository);
  });

  const tId = 'id';

  test('should get current id from the repository', () async {
    when(mockUserRepository.getCurrentId())
        .thenAnswer((_) async => const Right(tId));

    final result = await usecase.call();
    expect(result, const Right(tId));
    verify(mockUserRepository.getCurrentId());
    verifyNoMoreInteractions(mockUserRepository);
  });

  test('should return failure when get current id fails', () async {
    final exception = FirebaseAuthException(code: 'code', message: 'message');
    when(mockUserRepository.getCurrentId())
        .thenAnswer((_) async => Left(ServerFailure(exception.message!)));

    final result = await usecase.call();

    expect(result, Left(ServerFailure(exception.message!)));
    verify(mockUserRepository.getCurrentId());
    verifyNoMoreInteractions(mockUserRepository);
  });
}
