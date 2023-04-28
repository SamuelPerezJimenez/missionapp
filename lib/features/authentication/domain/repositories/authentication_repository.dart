import 'package:dartz/dartz.dart';
import 'package:mission_app/core/errors/failures.dart';
import 'package:mission_app/features/authentication/domain/entities/user.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, User>> login(String username, String password);
  Future<Either<Failure, User>> register(
      String username, String email, String password);
  Future<Either<Failure, void>> logout();

  Future<Either<Failure, User>> getActiveSessionUser();

  Future<Either<Failure, User>> updateProfileImage(
      String username, String imageUrl);
}
