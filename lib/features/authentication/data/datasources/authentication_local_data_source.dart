import 'package:bcrypt/bcrypt.dart';
import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mission_app/features/authentication/data/models/tables/user_table.dart';
import 'package:mission_app/features/authentication/data/models/user_model.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/user.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<void> cacheSession(UserModel userModel);
  Future<UserTable> getSession();
  Future<void> logout();
  Future<User?> login(String username, String password);
  Future<User> updateUser(String username, String newUrlProfileImage);
  Future<bool> userExists(String username, String email);
}

class AuthenticationLocalDataSourceImpl
    implements AuthenticationLocalDataSource {
  final Box<UserTable> userBox;

  AuthenticationLocalDataSourceImpl({required this.userBox});
  @override
  Future cacheSession(UserModel userModel) async {
    await userBox.put(
      'SESSION',
      UserTable.fromUserModel(userModel),
    );
  }

  @override
  Future<User?> login(String username, String password) async {
    final validUser = userBox.values.firstWhereOrNull((user) =>
        user.email == username && BCrypt.checkpw(password, user.password));

    if (validUser != null) {
      return UserModel.fromUserTable(validUser);
    }

    return null;
  }

  @override
  Future<void> logout() async {
    return await userBox.delete('SESSION');
  }

  @override
  Future saveUser(UserModel user) async {
    await userBox.add(
      UserTable.fromUserModel(user),
    );
  }

  @override
  Future<UserTable> getSession() {
    return Future.value(userBox.get('SESSION'));
  }

  @override
  Future<User> updateUser(String username, String newUrlProfileImage) async {
    final userIndex =
        userBox.values.toList().indexWhere((user) => user.username == username);

    if (userIndex != -1) {
      final user = userBox.getAt(userIndex);
      final updatedUser = UserModel(
        username: user!.username,
        email: user.email,
        password: user.password,
        urlProfileImage: newUrlProfileImage,
      );

      await userBox.putAt(userIndex, UserTable.fromUserModel(updatedUser));

      await cacheSession(updatedUser);
      return updatedUser;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> userExists(String username, String email) {
    final existingUser =
        userBox.values.firstWhereOrNull((user) => user.email == email);
    return Future.value(existingUser != null);
  }
}
