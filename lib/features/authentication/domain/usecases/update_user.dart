import 'package:dartz/dartz.dart';
import 'package:mission_app/features/authentication/domain/usecases/usecase.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../repositories/authentication_repository.dart';

class UpdateUser implements UseCase<User, UpdateUserParams> {
  final AuthenticationRepository repository;

  UpdateUser(this.repository);

  @override
  Future<Either<Failure, User>> call(UpdateUserParams params) async {
    return await repository.updateProfileImage(
        params.username, params.newUrlProfileImage);
  }
}

class UpdateUserParams {
  final String username;
  final String newUrlProfileImage;

  UpdateUserParams({required this.username, required this.newUrlProfileImage});
}
