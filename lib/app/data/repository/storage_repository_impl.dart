import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';
import '../data.dart';

class StorageRepositoryImpl implements StorageRepository {
  final StorageProvider storageProvider;

  StorageRepositoryImpl({required this.storageProvider});

  @override
  Future<Either<Failure, String>> defaultPicUrl(String imgNumber) async {
    try {
      final result = await storageProvider.defaultPicUrl(imgNumber);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePic(
      XFile file, Function(double p1)? onProgress) async {
    try {
      final result = await storageProvider.uploadProfilePic(file, onProgress);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
