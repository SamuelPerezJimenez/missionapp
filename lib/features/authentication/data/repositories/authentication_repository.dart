import 'package:bcrypt/bcrypt.dart';
import 'package:mission_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mission_app/features/authentication/data/datasources/authentication_local_data_source.dart';
import 'package:mission_app/features/authentication/data/models/user_model.dart';
import 'package:mission_app/features/authentication/domain/entities/user.dart';
import 'package:mission_app/features/authentication/domain/repositories/authentication_repository.dart';

import '../../../../core/errors/exceptions.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationLocalDataSource localDataSource;

  AuthenticationRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, User>> login(String username, String password) async {
    try {
      var userExist = await localDataSource.login(username, password);

      if (userExist != null) {
        return Right(userExist);
      } else {
        return const Left(InvalidCredentialsFailure());
      }
    } on UnauthorizedException {
      return const Left(UnauthorizedFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.logout();
      return const Right(null);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> register(
      String username, String email, String password) async {
    final salt = BCrypt.gensalt();
    final hashedPassword = BCrypt.hashpw(password, salt);

    try {
      final userExists = await localDataSource.userExists(username, email);

      if (userExists) {
        return const Left(UserExistsFailure());
      } else {
        final user = UserModel(
            username: username,
            email: email,
            password: hashedPassword,
            urlProfileImage: '');

        await localDataSource.saveUser(user);
        return Right(user);
      }
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> updateProfileImage(
      String username, String newUrlProfileImage) async {
    try {
      final updatedUser =
          await localDataSource.updateUser(username, newUrlProfileImage);
      return Right(updatedUser);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getActiveSessionUser() {
    try {
      return localDataSource.getSession().then((userTable) {
        return Right(UserModel.fromUserTable(userTable));
      });
    } on CacheException {
      return Future.value(const Left(CacheFailure()));
    }
  }
}
