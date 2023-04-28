import 'package:mission_app/features/authentication/data/datasources/authentication_local_data_source.dart';

import '../../../../core/repositories/session_repository.dart';
import '../../domain/entities/user.dart';
import '../models/user_model.dart';

class SessionRepositoryImpl implements SessionRepository {
  final AuthenticationLocalDataSource authenticationLocalDataSource;

  SessionRepositoryImpl({required this.authenticationLocalDataSource});

  @override
  Future<User> getCurrentUser() async {
    var user = await authenticationLocalDataSource.getSession();
    return user.toUserModel();
  }

  @override
  Future<void> setCurrentUser(UserModel user) async {
    return await authenticationLocalDataSource.cacheSession(user);
  }

  @override
  Future<void> clearCurrentUser() {
    return authenticationLocalDataSource.logout();
  }
}
