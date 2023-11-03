import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/core.dart';

abstract class StorageRepository {
  Future<Either<Failure, String>> uploadProfilePic(
      XFile file, Function(double)? onProgress);

  Future<Either<Failure, String>> defaultPicUrl(String imgNumber);
}
