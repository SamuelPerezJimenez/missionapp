import '../../features/authentication/data/models/user_model.dart';
import '../../features/authentication/domain/entities/user.dart';

abstract class SessionRepository {
  Future<User> getCurrentUser();
  Future<void> setCurrentUser(UserModel user);
  Future<void> clearCurrentUser();
}
