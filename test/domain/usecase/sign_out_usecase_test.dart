import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:patungan_id/app/domain/domain.dart';

import '../../helper/mock.mocks.dart';

void main() {
  late MockAuthRepository repo;
  late SignOutUsecase usecase;

  setUp(() {
    repo = MockAuthRepository();
    usecase = SignOutUsecase(repo);
  });

  test('should sign out', () async {
    when(repo.signOut()).thenAnswer((_) async => const Right(null));

    final result = await usecase.call();

    expect(result, const Right(null));
    verify(repo.signOut());
    verifyNoMoreInteractions(repo);
  });
}
