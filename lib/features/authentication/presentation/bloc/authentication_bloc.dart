import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/global_keys.dart';
import '../../../../core/repositories/session_repository.dart';
import '../../../../core/widgets/customSnackBar.dart';
import '../../data/models/user_model.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;
  final SessionRepository sessionRepository;

  AuthenticationBloc(
      {required this.authenticationRepository, required this.sessionRepository})
      : super(AuthenticationInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthenticationLoading());
      final result =
          await authenticationRepository.login(event.username, event.password);
      result.fold(
        (failure) {
          final snackBar = CustomSnackBar(scaffoldMessengerKey);
          snackBar.show(failure.message, SnackBarType.failure);
          emit(AuthenticationFailure(message: failure.message));
        },
        (user) {
          final snackBar = CustomSnackBar(scaffoldMessengerKey);
          snackBar.show("Bienvenido", SnackBarType.success);
          sessionRepository.setCurrentUser(UserModel(
            username: user.username,
            password: user.password,
            email: user.email,
            urlProfileImage: user.urlProfileImage,
          ));
          emit(AuthenticationAuthenticated(user: user));
        },
      );
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthenticationLoading());

      final result = await authenticationRepository.register(
          event.username, event.email, event.password);

      result.fold(
        (failure) {
          final snackBar = SnackBar(content: Text(failure.message));
          scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
          emit(RegistationFailure(message: failure.message));
        },
        (user) {
          final snackBar = CustomSnackBar(scaffoldMessengerKey);
          snackBar.show("Cuenta creada con éxito", SnackBarType.success);
          emit(RegistationSuccess(user: user));
        },
      );
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthenticationLoading());
      await sessionRepository.clearCurrentUser();
      emit(AuthenticationUnauthenticated());
    });

    on<GetActiveSessionUserEvent>((event, emit) async {
      emit(AuthenticationLoading());
      final result = await authenticationRepository.getActiveSessionUser();
      result.fold(
        (failure) {
          emit(AuthenticationFailure(message: failure.message));
        },
        (user) {
          emit(AuthenticationAuthenticated(user: user));
        },
      );
    });

    on<UpdateProfileImageEvent>((event, emit) async {
      emit(AuthenticationLoading());
      final result = await authenticationRepository.updateProfileImage(
          event.username, event.imageUrl);
      result.fold(
        (failure) {
          emit(AuthenticationFailure(message: failure.message));
        },
        (user) {
          emit(AuthenticationAuthenticated(user: user));
        },
      );
    });
  }
}
