import 'package:flutter/material.dart';

class RoundedElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;

  const RoundedElevatedButton({
    Key? key,
    this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
