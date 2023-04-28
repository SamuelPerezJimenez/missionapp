import 'package:dartz/dartz.dart';
import 'package:mission_app/features/authentication/domain/usecases/usecase.dart';
import 'package:mission_app/features/contacts/data/models/contact_model.dart';
import 'package:mission_app/features/contacts/domain/repositories/contact_repository.dart';

import '../../../../core/errors/failures.dart';

class CreateContact implements UseCase<void, ContactModel> {
  final ContactRepository repository;

  CreateContact(this.repository);

  @override
  Future<Either<Failure, void>> call(ContactModel contact) async {
    return await repository.createContact(contact);
  }
}
