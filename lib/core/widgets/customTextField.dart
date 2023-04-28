import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {super.key,
      this.validator,
      this.onChanged,
      this.onLongInput,
      this.onShortInput,
      this.labelText = "",
      this.keyboardType,
      this.inputFormatters,
      this.controller,
      this.iconData,
      this.obscureText = false});
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onLongInput;
  final void Function(String)? onShortInput;
  final String labelText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final IconData? iconData;

  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        onChanged: (text) {
          widget.onChanged?.call(text);
          if (text.length > 3) {
            widget.onLongInput?.call(text);
          } else {
            widget.onShortInput?.call(text);
          }
        },
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText ? _obscureText : false,
        inputFormatters: widget.inputFormatters,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
            prefixIcon: widget.iconData != null ? Icon(widget.iconData) : null,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            labelStyle: const TextStyle(fontSize: 20),
            border: const UnderlineInputBorder(),
            hintText: widget.labelText,
            hintStyle: TextStyle(color: Colors.grey[400])),
      ),
    );
  }
}
