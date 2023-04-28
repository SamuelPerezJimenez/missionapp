import 'package:dartz/dartz.dart';
import 'package:mission_app/features/authentication/domain/usecases/usecase.dart';
import 'package:mission_app/features/contacts/domain/repositories/contact_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/contact_model.dart';

class UpdateContact implements UseCase<void, UpdateContactParams> {
  final ContactRepository repository;

  UpdateContact(this.repository);

  @override
  Future<Either<Failure, void>> call(params) async {
    return repository.udpdateContact(params.id, params.contact);
  }
}

class UpdateContactParams {
  final int id;
  final ContactModel contact;

  UpdateContactParams({required this.contact, required this.id});
}
