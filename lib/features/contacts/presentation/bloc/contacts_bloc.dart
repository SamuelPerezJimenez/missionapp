import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mission_app/features/contacts/data/models/contact_model.dart';

import '../../../../core/global_keys.dart';
import '../../../../core/repositories/session_repository.dart';
import '../../../../core/widgets/customSnackBar.dart';
import '../../domain/entities/contact.dart';
import '../../domain/usecases/create_contact.dart';
import '../../domain/usecases/get_contacts.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final CreateContact createContact;
  final GetContacts getContacts;
  final SessionRepository sessionRepository;

  ContactsBloc(
      {required this.createContact,
      required this.getContacts,
      required this.sessionRepository})
      : super(ContactsInitial()) {
    on<CreateContactEvent>((event, emit) async {
      emit(ContactsLoading());

      var user = await sessionRepository.getCurrentUser();

      final result = await createContact(ContactModel(
          name: event.name,
          identification: event.identification,
          userEmail: user.email));

      final snackBar = CustomSnackBar(scaffoldMessengerKey);
      snackBar.show("Contacto creado correctamente.", SnackBarType.success);
      result.fold(
        (failure) => emit(ContactsError(failure.message)),
        (_) => emit(ContactCreated()),
      );
    });

    on<GetContactsEvent>((event, emit) async {
      emit(ContactsLoading());
      var usuario = await sessionRepository.getCurrentUser();

      final result = await getContacts(
          GetContactsParams(query: event.query, userEmail: usuario.email));
      result.fold(
        (failure) => emit(ContactsError(failure.message)),
        (contacts) => emit(ContactsLoaded(contacts)),
      );
    });
  }
}
