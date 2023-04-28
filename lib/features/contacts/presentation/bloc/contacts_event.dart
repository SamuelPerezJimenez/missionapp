part of 'contacts_bloc.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class CreateContactEvent extends ContactsEvent {
  final String name;
  final int identification;

  const CreateContactEvent({
    required this.name,
    required this.identification,
  });

  @override
  List<Object> get props => [name, identification];
}

class GetContactsEvent extends ContactsEvent {
  final String query;

  const GetContactsEvent({required this.query});

  @override
  List<Object> get props => [query];
}
