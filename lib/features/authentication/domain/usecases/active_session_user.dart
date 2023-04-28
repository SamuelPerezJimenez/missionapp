import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/authentication_repository.dart';

class ActiveSessionUser {
  final AuthenticationRepository repository;

  ActiveSessionUser(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.getActiveSessionUser();
  }
}
