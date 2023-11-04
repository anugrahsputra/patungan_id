import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class SaveToDatabaseUsecase {
  final AuthRepository authRepository;

  SaveToDatabaseUsecase(this.authRepository);

  Future<Either<Failure, void>> call(String name, String photoUrl) async {
    return await authRepository.saveDataToDatabase(name, photoUrl);
  }
}
