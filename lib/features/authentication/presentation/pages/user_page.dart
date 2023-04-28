import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mission_app/core/theme/theme.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/widgets/customDialog.dart';
import '../../../../core/widgets/roundedElevatedButton.dart';
import '../bloc/authentication_bloc.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  UserProfilePageState createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  String? _imageUrl;
  String? _username;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<AuthenticationBloc>(context, listen: false)
        .add(GetActiveSessionUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (BuildContext context, AuthenticationState authState) {
        if (authState is AuthenticationAuthenticated) {
          _imageUrl = authState.user.urlProfileImage;
          _username = authState.user.username;
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Text(authState.user.username),
              actions: [
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => CustomDialog(
                          title: 'Cerrar sesión',
                          message: '¿Esta seguro que desea cerrar sesión?',
                          onYesPressed: () {
                            if (mounted) {
                              context
                                  .read<AuthenticationBloc>()
                                  .add(LogoutEvent());
                            }
                            Navigator.of(context).pop();
                          },
                          onNoPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.logout))
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: AppTheme.primaryColor,
                    radius: 100,
                    backgroundImage:
                        _imageUrl != '' ? FileImage(File(_imageUrl!)) : null,
                    child: _imageUrl == ''
                        ? const Icon(Icons.person, size: 100)
                        : null,
                  ),
                  const SizedBox(height: 26),
                  Padding(
                    padding: pagePadding,
                    child: RoundedElevatedButton(
                      onPressed: _changeProfileImage,
                      buttonText: 'Cambiar foto de perfil',
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('No user session found.'));
        }
      },
    );
  }

  Future<void> _changeProfileImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Tomar foto'),
              onTap: () async {
                Navigator.pop(context);
                await _getImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Seleccionar de la galería'),
              onTap: () async {
                Navigator.pop(context);
                await _getImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    // Selecciona una nueva imagen.
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      // Obtiene el directorio de documentos del dispositivo.
      final documentsDirectory = await getApplicationDocumentsDirectory();

      // Copia la imagen seleccionada al directorio de documentos con un nombre de archivo único.
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      final newImageFile = await File(pickedImage.path)
          .copy('${documentsDirectory.path}/$currentTime.jpg');

      // Actualiza la imagen de perfil del usuario.
      if (mounted) {
        context.read<AuthenticationBloc>().add(
              UpdateProfileImageEvent(
                username: _username!,
                imageUrl: newImageFile.path,
              ),
            );
      }
    }
  }
}
