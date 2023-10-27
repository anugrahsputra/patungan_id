import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:patungan_id/app/domain/domain.dart';

import '../../../helper/mock.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late GetUserByIdUsecase usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = GetUserByIdUsecase(mockAuthRepository);
  });

  const uid = 'id';

  test('should get user by id from the repository', () async {
    const user = UserEntity(
        id: 'id',
        phoneNumber: 'phoneNumber',
        name: 'name',
        profilePic: 'profilePic',
        groupId: [],
        friendsId: []);

    when(mockAuthRepository.getUserById(uid))
        .thenAnswer((_) => Stream.value(user));

    final result = usecase.call(uid);

    await expectLater(result, emits(user));
    verify(mockAuthRepository.getUserById(uid));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
