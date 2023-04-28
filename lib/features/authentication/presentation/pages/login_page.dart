import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/customTextField.dart';
import '../../../../core/widgets/roundedElevatedButton.dart';
import '../bloc/authentication_bloc.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reto técnico'),
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 56,
                child: Padding(
                  padding: pagePadding,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(bottom: 84),
                            child: const Icon(Icons.contacts,
                                size: 100, color: AppTheme.primaryColor)),
                        CustomTextFormField(
                          labelText: 'Usuario',
                          controller: _usernameController,
                          iconData: Icons.person_outline_outlined,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            _updateButtonState();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          labelText: 'Contraseña',
                          controller: _passwordController,
                          obscureText: true,
                          iconData: Icons.lock_outlined,
                          onChanged: (value) {
                            _updateButtonState();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()),
                              );
                            },
                            child: const Text(
                              'No tengo cuenta',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        RoundedElevatedButton(
                          onPressed: _isButtonEnabled
                              ? () {
                                  context.read<AuthenticationBloc>().add(
                                      LoginEvent(
                                          username: _usernameController.text,
                                          password: _passwordController.text));
                                }
                              : null,
                          buttonText: 'Iniciar sesión',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
