import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_read/shared/helpers.dart';

class MyTextInputField extends StatelessWidget {
  /// A custom text input widget
  const MyTextInputField({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    this.obscureText = false,
    required this.onChanged,
    this.validator,
    this.inputFormatters,
  }) : super(key: key);

  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: myDefaultSize),
      child: TextFormField(
        decoration: decorateTextInput(hintText: hintText),
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
