import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';
import 'package:patungan_id/app/core/core.dart';
import 'package:patungan_id/app/data/data.dart';
import 'package:patungan_id/app/domain/domain.dart';

import '../../helper/mock.mocks.dart';

void main() {
  MockStorageProvider mockStorageProvider = MockStorageProvider();
  StorageRepository storageRepository =
      StorageRepositoryImpl(storageProvider: mockStorageProvider);

  const imgNumber = '1';
  const downloadUrl =
      'https://example.com/default_avatar/default($imgNumber).svg';

  group("defaultProfilePic", () {
    test("should return result", () async {
      when(mockStorageProvider.defaultPicUrl(imgNumber))
          .thenAnswer((_) async => downloadUrl);

      final result = await storageRepository.defaultPicUrl(imgNumber);

      expect(result, const Right(downloadUrl));
      verify(mockStorageProvider.defaultPicUrl(imgNumber));
      verifyNoMoreInteractions(mockStorageProvider);
    });
    test('should return a ServerFailure when an exception is thrown', () async {
      final exception = ServerException();
      when(mockStorageProvider.defaultPicUrl(imgNumber)).thenThrow(exception);

      final result = await storageRepository.defaultPicUrl(imgNumber);

      expect(result, equals(Left(ServerFailure(exception.toString()))));
      verify(mockStorageProvider.defaultPicUrl(imgNumber));
      verifyNoMoreInteractions(mockStorageProvider);
    });
  });

  group('uploadProfilePic', () {
    const filePath = '/path/to/image.jpg';
    final file = XFile(filePath);
    const progress = 0.5;
    const url = 'https://example.com/image.jpg';

    test('should upload the profile picture and return the URL', () async {
      when(mockStorageProvider.uploadProfilePic(file, any))
          .thenAnswer((_) async => url);

      final result = await storageRepository.uploadProfilePic(file, (p) {});

      expect(result, equals(const Right(url)));
      verify(mockStorageProvider.uploadProfilePic(file, any));
      verifyNoMoreInteractions(mockStorageProvider);
    });

    test('should call the onProgress callback with the upload progress',
        () async {
      final completer = Completer<String>();
      when(mockStorageProvider.uploadProfilePic(file, any))
          .thenAnswer((_) => completer.future);

      double? progressValue;
      onProgress(double p) {
        progressValue = p;
        if (p >= progress) {
          completer.complete(url);
        }
      }

      onProgress(progress);

      await storageRepository.uploadProfilePic(file, onProgress);

      expect(progressValue, isNotNull);
      expect(progressValue, greaterThanOrEqualTo(0.0));
      expect(progressValue, lessThanOrEqualTo(1.0));
    });
    test('should return a ServerFailure when an exception is thrown', () async {
      final exception = ServerException();
      when(mockStorageProvider.uploadProfilePic(file, any))
          .thenThrow(exception);

      final result = await storageRepository.uploadProfilePic(file, (p) {});

      expect(result, equals(Left(ServerFailure(exception.toString()))));
      verify(mockStorageProvider.uploadProfilePic(file, any));
      verifyNoMoreInteractions(mockStorageProvider);
    });
  });
}
