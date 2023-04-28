import 'package:mission_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mission_app/features/contacts/data/datasources/contacts_local_data_source.dart';
import 'package:mission_app/features/contacts/data/models/contact_model.dart';
import 'package:mission_app/features/contacts/domain/entities/contact.dart';
import 'package:mission_app/features/contacts/domain/repositories/contact_repository.dart';

import '../../../../core/errors/exceptions.dart';

class ContactsRepositoryImpl implements ContactRepository {
  final ContactsLocalDataSource localDataSource;

  ContactsRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, Contact>> createContact(Contact contactModel) async {
    try {
      final contact = ContactModel(
          name: contactModel.name,
          identification: contactModel.identification,
          userEmail: contactModel.userEmail!);
      await localDataSource.saveContact(contact);
      return Right(contact);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<ContactModel>>> getContacts(
      String query, String userEmail) async {
    try {
      return Right(await localDataSource.getContacts(query, userEmail));
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> udpdateContact(
      int id, ContactModel contact) async {
    try {
      final updatedContact = await localDataSource.updateContact(id, contact);
      return Right(updatedContact);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }
}
