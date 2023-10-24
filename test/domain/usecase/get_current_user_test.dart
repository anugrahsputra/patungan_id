import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:patungan_id/app/core/core.dart';
import 'package:patungan_id/app/data/data.dart';
import 'package:patungan_id/app/domain/domain.dart';

import '../../helper/mock.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late GetCurrentUerUsecase usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = GetCurrentUerUsecase(mockAuthRepository);
  });

  const tuser = UserModel(
      id: 'id',
      phoneNumber: 'phoneNumber',
      name: 'name',
      profilePic: 'profilePic',
      groupId: [],
      friendsId: []);

  test('should sign in with phone number from the repository', () async {
    when(mockAuthRepository.getCurrentUser())
        .thenAnswer((_) async => const Right(tuser));

    final result = await usecase.call();
    expect(result, const Right(tuser));
    verify(mockAuthRepository.getCurrentUser());
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return failure when sign in with phone number fails', () async {
    final exception = FirebaseAuthException(code: 'code', message: 'message');
    when(mockAuthRepository.getCurrentUser())
        .thenAnswer((_) async => Left(ServerFailure(exception.message!)));

    final result = await usecase.call();

    expect(result, Left(ServerFailure(exception.message!)));
    verify(mockAuthRepository.getCurrentUser());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
