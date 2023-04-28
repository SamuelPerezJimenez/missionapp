import 'package:dartz/dartz.dart';

import '../repositories/authentication_repository.dart';
import '../../../../core/errors/failures.dart';

class LogOutUser {
  final AuthenticationRepository repository;

  LogOutUser(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.logout();
  }
}
