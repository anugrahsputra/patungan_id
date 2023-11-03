import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class GetDefaultProfilePicUsecase {
  final StorageRepository repository;

  GetDefaultProfilePicUsecase({required this.repository});

  Future<Either<Failure, String>> call(String imgNumber) async =>
      await repository.defaultPicUrl(imgNumber);
}
