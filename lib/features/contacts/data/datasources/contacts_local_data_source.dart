import 'package:hive_flutter/hive_flutter.dart';

import '../models/contact_model.dart';
import '../models/tables/contact_table.dart';

abstract class ContactsLocalDataSource {
  Future<void> saveContact(ContactModel contact);
  Future<void> updateContact(int id, ContactModel contact);
  Future<List<ContactModel>> getContacts(String? query, String userEmail);
}

class ContactsLocalDataSourceImpl implements ContactsLocalDataSource {
  final Box<ContactTable> contactBox;

  ContactsLocalDataSourceImpl({required this.contactBox});

  @override
  Future<List<ContactModel>> getContacts(String? query, String userEmail) {
    return Future.value(
      [
        for (final element in contactBox.values)
          if (query == null ||
              element.name.contains(query) && element.userEmail == userEmail)
            ContactModel.fromContactTable(element),
      ],
    );
  }

  @override
  Future<void> saveContact(ContactModel contact) async {
    await contactBox.add(ContactTable.fromContactModel(contact));
  }

  @override
  Future<void> updateContact(int id, ContactModel contact) async {
    await contactBox.put(
      id,
      ContactTable.fromContactModel(contact),
    );
  }
}
