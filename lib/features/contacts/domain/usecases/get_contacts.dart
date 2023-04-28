import 'package:dartz/dartz.dart';
import 'package:mission_app/features/authentication/domain/usecases/usecase.dart';
import 'package:mission_app/features/contacts/domain/entities/contact.dart';
import 'package:mission_app/features/contacts/domain/repositories/contact_repository.dart';

import '../../../../core/errors/failures.dart';

class GetContacts implements UseCase<List<Contact>, GetContactsParams> {
  final ContactRepository repository;

  GetContacts(this.repository);

  @override
  Future<Either<Failure, List<Contact>>> call(GetContactsParams params) async {
    return repository.getContacts(params.query, params.userEmail);
  }
}

class GetContactsParams {
  final String query;
  final String userEmail;

  GetContactsParams({required this.query, required this.userEmail});
}
