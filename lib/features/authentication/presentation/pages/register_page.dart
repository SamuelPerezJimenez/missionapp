import 'package:flutter/material.dart';
import 'package:mission_app/core/theme/theme.dart';

import '../../../../core/widgets/customTextField.dart';
import '../../../../core/widgets/roundedElevatedButton.dart';
import '../../../../injection_container.dart';
import '../bloc/authentication_bloc.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar usuario'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: pagePadding,
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    labelText: 'Usuario',
                    controller: _usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un usuario';
                      } else if (value.length < 4 || value.length > 50) {
                        return 'El usuario debe tener entre 4 y 50 caracteres';
                      } else if (!RegExp(r'^[a-zA-Z]*$').hasMatch(value)) {
                        return 'El usuario no debe contener números ni caracteres especiales';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    labelText: 'Correo',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un correo';
                      } else if (value.length < 6 || value.length > 50) {
                        return 'El correo debe tener entre 6 y 50 caracteres';
                      } else if (!RegExp(
                              r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
                          .hasMatch(value)) {
                        return 'Por favor ingrese un correo válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    labelText: 'Contraseña',
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese una contraseña';
                      } else if (value.length < 10 || value.length > 60) {
                        return 'La contraseña debe tener entre 10 y 60 caracteres';
                      } else if (!RegExp(
                              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
                          .hasMatch(value)) {
                        return 'La contraseña debe tener al menos una letra mayúscula, una minúscula, un número y un carácter especial';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: _confirmPasswordController,
                    labelText: 'Confirmar contraseña',
                    obscureText: true,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Las contraseñas no coinciden';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  RoundedElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final authenticationBloc = sl<AuthenticationBloc>();

                        authenticationBloc.add(RegisterEvent(
                          username: _usernameController.text,
                          email: _emailController.text,
                          password: _confirmPasswordController.text,
                        ));

                        Navigator.pop(context);
                      }
                    },
                    buttonText: 'Registrame',
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
