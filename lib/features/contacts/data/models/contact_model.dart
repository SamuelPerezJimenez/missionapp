import '../../domain/entities/contact.dart';
import 'tables/contact_table.dart';

class ContactModel extends Contact {
  const ContactModel(
      {required String name,
      required int identification,
      required String userEmail})
      : super(name: name, identification: identification, userEmail: userEmail);

  factory ContactModel.fromContactTable(ContactTable contactTable) {
    return ContactModel(
      name: contactTable.name,
      identification: contactTable.identification,
      userEmail: contactTable.userEmail,
    );
  }
}
