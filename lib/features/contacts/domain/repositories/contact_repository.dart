import 'package:dartz/dartz.dart';
import 'package:mission_app/core/errors/failures.dart';
import 'package:mission_app/features/contacts/domain/entities/contact.dart';

import '../../data/models/contact_model.dart';

abstract class ContactRepository {
  Future<Either<Failure, void>> udpdateContact(int id, ContactModel contact);

  Future<Either<Failure, void>> createContact(ContactModel contact);

  Future<Either<Failure, List<Contact>>> getContacts(
      String query, String userEmail);
}
