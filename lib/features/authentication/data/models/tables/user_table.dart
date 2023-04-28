import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:mission_app/features/authentication/data/models/user_model.dart';

part 'user_table.g.dart';

@HiveType(typeId: 1)
class UserTable extends HiveObject {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String password;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String urlProfileImage;

  UserTable({
    required this.username,
    required this.password,
    required this.email,
    required this.urlProfileImage,
  });

  factory UserTable.fromUserModel(UserModel userModel) {
    return UserTable(
      username: userModel.username,
      password: userModel.password,
      email: userModel.email,
      urlProfileImage: userModel.urlProfileImage ?? '',
    );
  }

  UserModel toUserModel() {
    return UserModel(
      username: username,
      password: password,
      email: email,
      urlProfileImage: urlProfileImage,
    );
  }
}
