import 'package:dartz/dartz.dart';

import '../../../contacts/domain/usecases/usecase.dart';
import '../repositories/authentication_repository.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

class RegisterUser implements UseCase<User, RegisterParams> {
  final AuthenticationRepository repository;

  RegisterUser(this.repository);

  @override
  Future<Either<Failure, User>> call(RegisterParams params) async {
    return await repository.register(
        params.username, params.email, params.password);
  }
}

class RegisterParams {
  final String username;
  final String email;
  String password;

  RegisterParams(
      {required this.username, required this.email, required this.password});
}
