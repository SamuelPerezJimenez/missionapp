import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/customTextField.dart';
import '../../../../injection_container.dart';
import '../bloc/contacts_bloc.dart';
import 'create_contact_page.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var contactsBloc = sl<ContactsBloc>();

    return BlocProvider(
      create: (_) => contactsBloc..add(const GetContactsEvent(query: '')),
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Mis contactos"),
          ),
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    labelText: "Buscar contacto",
                    onLongInput: (input) {
                      contactsBloc.add(GetContactsEvent(query: input));
                    },
                    onShortInput: (input) {
                      contactsBloc.add(const GetContactsEvent(query: ''));
                    },
                  ),
                ),
                BlocBuilder<ContactsBloc, ContactsState>(
                  builder: (context, state) {
                    if (state is ContactsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ContactsError) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else if (state is ContactsLoaded) {
                      final contacts = state.contacts.reversed.toList();
                      return Expanded(
                        child: ListView.builder(
                          key: UniqueKey(),
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            final contact = contacts[index];
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              title: Text(
                                contact.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: AppTheme.primaryColor),
                              ),
                              subtitle: Text(
                                contact.identification.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: AppTheme.primaryColor),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: contactsBloc,
                    child: const CreateContactPage(),
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          )),
    );
  }
}
