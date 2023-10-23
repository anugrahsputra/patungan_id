import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:patungan_id/app/data/data.dart';

import '../../helper/mock.mocks.dart';

void main() {
  MockFirebaseAuth mockAuth = MockFirebaseAuth();
  MockFirebaseFirestore mockFirestore = MockFirebaseFirestore();
  MockSharedPreferences mockSharedPreferences = MockSharedPreferences();
  MockUser mockUser = MockUser();

  AuthProvider authProvider =
      AuthProviderImpl(mockAuth, mockFirestore, mockSharedPreferences);

  final userData = {
    'id': '123',
    'phoneNumber': '+1234567890',
    'name': 'John Doe',
    'profilePic': '',
    'groupId': [],
    'friendsId': [],
  };
  final userDoc = MockDocumentSnapshot<Map<String, dynamic>>();
  final mockDocumentReference = MockDocumentReference<Map<String, dynamic>>();
  final mockCollectionReference =
      MockCollectionReference<Map<String, dynamic>>();
  var mockDocumentSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();
  group(
    "getCurrentId",
    () {
      test('returns the current user id', () async {
        when(mockAuth.currentUser).thenReturn(mockUser);
        var result = await authProvider.getCurrentId();
        expect(result, mockUser.uid);
      });
    },
  );

  group("getCurrentUser", () {
    test('returns the current user', () async {
      when(userDoc.data()).thenReturn(userData);
      when(mockAuth.currentUser).thenReturn(mockUser);

      when(mockDocumentSnapshot.exists).thenReturn(true);
      when(mockDocumentSnapshot.data()).thenReturn(userData);

      when(mockDocumentReference.get())
          .thenAnswer((_) async => mockDocumentSnapshot);

      when(mockCollectionReference.doc(mockUser.uid))
          .thenReturn(mockDocumentReference);

      when(mockFirestore.collection('users'))
          .thenReturn(mockCollectionReference);

      final user = await authProvider.getCurrentUser();
      expect(user, isA<UserModel>());
      expect(user.phoneNumber, '+1234567890');
      expect(user.name, 'John Doe');
    });
  });
}
