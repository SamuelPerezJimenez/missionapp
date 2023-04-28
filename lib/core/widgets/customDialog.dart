import 'package:flutter/material.dart';

import '../theme/theme.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onYesPressed;
  final VoidCallback onNoPressed;
  final String yesText;
  final String noText;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.onYesPressed,
    required this.onNoPressed,
    this.yesText = 'Si, cerrar',
    this.noText = 'No',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            top: 65,
            bottom: 20,
            left: 20,
            right: 20,
          ),
          margin: const EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16.0),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDialogButton(context,
                        text: noText, onPressed: onNoPressed),
                    _buildDialogButton(context,
                        text: yesText, onPressed: onYesPressed),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: AppTheme.primaryColor,
            radius: 50,
            child: Icon(
              Icons.help_outline,
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDialogButton(BuildContext context,
      {required String text, required VoidCallback onPressed}) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
