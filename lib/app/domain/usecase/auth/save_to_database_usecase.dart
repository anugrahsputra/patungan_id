import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class SaveToDatabaseUsecase {
  final AuthRepository authRepository;

  SaveToDatabaseUsecase(this.authRepository);

  Future<Either<Failure, void>> call(String name) async {
    return await authRepository.saveDataToDatabase(name);
  }
}
