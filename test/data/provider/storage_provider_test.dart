import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:patungan_id/app/data/data.dart';

import '../../helper/mock.mocks.dart';

void main() {
  late MockFirebaseStorage mockFirebaseStorage;
  late StorageProvider storageProvider;

  setUp(() {
    mockFirebaseStorage = MockFirebaseStorage();
    storageProvider = StorageProviderImpl(storage: mockFirebaseStorage);
  });

  group('defaultPicUrl', () {
    test('should return default avatar url', () async {
      final mockReference = MockReference();
      const imgNumber = '1';
      const downloadUrl =
          'https://example.com/default_avatar/default($imgNumber).svg';

      when(mockFirebaseStorage.ref('default_avatar/default(1).svg'))
          .thenReturn(mockReference);
      when(mockReference.getDownloadURL()).thenAnswer((_) async => downloadUrl);

      final defaultPicUrl = await storageProvider.defaultPicUrl(imgNumber);
      expect(
          defaultPicUrl, 'https://example.com/default_avatar/default(1).svg');
    });
  });
}
