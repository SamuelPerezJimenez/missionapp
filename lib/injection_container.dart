import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mission_app/features/authentication/data/datasources/authentication_local_data_source.dart';
import 'package:mission_app/features/authentication/data/models/tables/user_table.dart';
import 'package:mission_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:mission_app/features/authentication/domain/usecases/logout_user.dart';
import 'package:mission_app/features/authentication/domain/usecases/register_user.dart';
import 'package:mission_app/features/authentication/domain/usecases/update_user.dart';
import 'package:mission_app/features/contacts/data/datasources/contacts_local_data_source.dart';
import 'package:mission_app/features/contacts/data/models/tables/contact_table.dart';
import 'package:mission_app/features/contacts/data/repositories/contacts_repository.dart';
import 'package:mission_app/features/contacts/domain/repositories/contact_repository.dart';
import 'package:mission_app/features/contacts/domain/usecases/get_contacts.dart';
import 'package:mission_app/features/contacts/domain/usecases/update_contact.dart';
import 'package:mission_app/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:mission_app/features/navigation/bloc/navigation_bloc.dart';

import 'core/repositories/session_repository.dart';
import 'features/authentication/data/repositories/authentication_repository.dart';
import 'features/authentication/data/repositories/session_repository.dart';
import 'features/authentication/domain/usecases/login_user.dart';
import 'features/authentication/presentation/bloc/authentication_bloc.dart';
import 'features/contacts/domain/usecases/create_contact.dart';

final sl = GetIt.instance;

Future<void> init() async {
//Use cases
  sl.registerLazySingleton(() => CreateContact(sl()));
  sl.registerLazySingleton(() => UpdateContact(sl()));
  sl.registerLazySingleton(() => GetContacts(sl()));

  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => LogOutUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => UpdateUser(sl()));

//Repositories
  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(sl()));

  sl.registerLazySingleton<ContactRepository>(
      () => ContactsRepositoryImpl(sl()));

//HIVE

  Hive.registerAdapter(ContactTableAdapter());
  Hive.registerAdapter(UserTableAdapter());

  sl.registerFactory<Box<ContactTable>>(
      () => Hive.box<ContactTable>('CONTACT'));

  await Hive.openBox<ContactTable>('CONTACT');

  sl.registerFactory<Box<UserTable>>(() => Hive.box<UserTable>('USER'));

  await Hive.openBox<UserTable>('USER');

//Datasources

  sl.registerLazySingleton<ContactsLocalDataSource>(
    () => ContactsLocalDataSourceImpl(contactBox: sl()),
  );

  sl.registerLazySingleton<AuthenticationLocalDataSource>(
    () => AuthenticationLocalDataSourceImpl(userBox: sl()),
  );

  sl.registerLazySingleton<SessionRepository>(() => SessionRepositoryImpl(
        authenticationLocalDataSource: sl(),
      ));

//Blocs

  sl.registerFactory(() => NavigationBloc());
  sl.registerFactory(() => AuthenticationBloc(
      authenticationRepository: sl(), sessionRepository: sl()));
  sl.registerFactory(() => ContactsBloc(
      createContact: sl(), getContacts: sl(), sessionRepository: sl()));

//External
}
