import 'package:mission_app/features/authentication/data/models/tables/user_table.dart';
import 'package:mission_app/features/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required String username,
      required String password,
      required String email,
      required String? urlProfileImage})
      : super(
            username: username,
            password: password,
            email: email,
            urlProfileImage: urlProfileImage);

  // from userTable

  factory UserModel.fromUserTable(UserTable userTable) {
    return UserModel(
        username: userTable.username,
        password: userTable.password,
        email: userTable.email,
        urlProfileImage: userTable.urlProfileImage);
  }
}
