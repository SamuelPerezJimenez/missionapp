import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import '../contact_model.dart';

part 'contact_table.g.dart';

@HiveType(typeId: 2)
class ContactTable extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int identification;

  @HiveField(2)
  final String userEmail;

  ContactTable({
    required this.name,
    required this.identification,
    required this.userEmail,
  });

  factory ContactTable.fromContactModel(ContactModel contactModel) {
    return ContactTable(
      name: contactModel.name,
      identification: contactModel.identification,
      userEmail: contactModel.userEmail ?? "",
    );
  }

  ContactModel toContactModel() {
    return ContactModel(
      name: name,
      identification: identification,
      userEmail: userEmail,
    );
  }
}
