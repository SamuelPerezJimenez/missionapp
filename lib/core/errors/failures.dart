import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  final String message;

  const Failure({this.properties = const <dynamic>[], this.message = ''});

  @override
  List<Object> get props => [properties, message];
}

// General failures

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure() : super(message: 'Credenciales inválidas.');
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure()
      : super(message: 'Sin autorización. Inicie sesión de nuevo.');
}

class UserExistsFailure extends Failure {
  const UserExistsFailure()
      : super(message: 'No se puede crear, usuario existente.');
}

class CacheFailure extends Failure {
  const CacheFailure()
      : super(message: 'Error inesperado. Inténtalo de nuevo.');
}

//Contacts

class ContactNotFoundFailure extends Failure {
  const ContactNotFoundFailure()
      : super(
            message:
                'Contacto no encontrado. Por favor, compruebe los datos de contacto.');
}

class DuplicateContactFailure extends Failure {
  const DuplicateContactFailure()
      : super(
            message:
                'El contacto ya existe. Utilice una identificación diferente.');
}

class InvalidContactDataFailure extends Failure {
  const InvalidContactDataFailure()
      : super(
            message:
                'Datos de contacto no válidos. Por favor, compruebe los datos de contacto.');
}

String mapFailureToMessage(Failure failure) {
  return failure.message;
}
