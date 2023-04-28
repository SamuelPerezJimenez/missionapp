import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/customTextField.dart';
import '../../../../core/widgets/roundedElevatedButton.dart';
import '../bloc/contacts_bloc.dart';

class CreateContactPage extends StatefulWidget {
  const CreateContactPage({Key? key}) : super(key: key);

  @override
  CreateContactPageState createState() => CreateContactPageState();
}

class CreateContactPageState extends State<CreateContactPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  StreamSubscription? _subscription;
  bool _isButtonEnabled = false;

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _formKey.currentState?.validate() ?? false;
    });
  }

  void _saveContact() {
    if (_formKey.currentState?.validate() ?? false) {
      final contactsBloc = BlocProvider.of<ContactsBloc>(context);
      contactsBloc.add(CreateContactEvent(
          name: _nameController.text,
          identification: int.parse(_idController.text)));
    }
  }

  @override
  void initState() {
    super.initState();

    final contactsBloc = BlocProvider.of<ContactsBloc>(context);
    _subscription = contactsBloc.stream.listen((state) {
      if (state is ContactCreated) {
        if (mounted) {
          contactsBloc.add(const GetContactsEvent(query: ""));
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Crear contacto"),
          ),
          body: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              padding: pagePadding,
              child: Column(
                children: <Widget>[
                  CustomTextFormField(
                    labelText: 'Nombre del contacto',
                    controller: _nameController,
                    onChanged: (value) {
                      _updateButtonState();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, introduce el nombre del contacto';
                      }
                      //Se cambio la validacion a 4 pues el buscador requiere 4 para buscar
                      if (value.length < 4 || value.length > 50) {
                        return 'El nombre del contacto debe tener entre 4 y 50 caracteres';
                      }
                      if (value.contains(RegExp(r'[0-9]'))) {
                        return 'El nombre no puede contener números';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    labelText: 'Identificación',
                    controller: _idController,
                    onChanged: (value) {
                      _updateButtonState();
                    },
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, introduce la identificación';
                      }
                      if (value.length < 6 || value.length > 10) {
                        return 'La identificación debe tener entre 6 y 10 caracteres';
                      }
                      if (!value.contains(RegExp(r'^[0-9]+$'))) {
                        return 'La identificación solo puede contener números';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  RoundedElevatedButton(
                    onPressed: _isButtonEnabled ? _saveContact : null,
                    buttonText: 'Guardar contacto',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
