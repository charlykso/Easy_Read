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
    this.initialValue,
  }) : super(key: key);

  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: myDefaultSize * 1.4),
      child: Material(
        elevation: 10.0,
        shadowColor: Colors.black54,
        borderRadius: BorderRadius.circular(myDefaultSize * .8),
        child: TextFormField(
          decoration: decorateTextInput(hintText: hintText),
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: initialValue,
        ),
      ),
    );
  }
}
