part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthenticationEvent {
  final String username;
  final String password;

  const LoginEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class RegisterEvent extends AuthenticationEvent {
  final String username;
  final String email;
  final String password;

  const RegisterEvent(
      {required this.username, required this.email, required this.password});

  @override
  List<Object> get props => [username, email, password];
}

class LogoutEvent extends AuthenticationEvent {}

class UpdateProfileImageEvent extends AuthenticationEvent {
  final String username;
  final String imageUrl;

  const UpdateProfileImageEvent(
      {required this.username, required this.imageUrl});

  @override
  List<Object> get props => [username, imageUrl];
}

class GetActiveSessionUserEvent extends AuthenticationEvent {}
