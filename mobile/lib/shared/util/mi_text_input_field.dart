import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class MiTextInputField extends StatelessWidget {
  /// A custom text input widget
  const MiTextInputField({
    Key? key,
    required this.hintText,
    required this.textInputType,
    this.obscureText = false,
    required this.onChanged,
    required this.validator,
    this.inputFormatters,
  }) : super(key: key);

  final String hintText;
  final TextInputType textInputType;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: miDefaultSize),
      child: TextFormField(
        decoration: decorateTextInput(hintText: hintText),
        inputFormatters: inputFormatters,
        keyboardType: TextInputType.name,
        obscureText: obscureText,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({bool focused = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(miDefaultSize * 1.43),
      borderSide: focused ? BorderSide(color: miPrimaryColor) : BorderSide.none,
    );
  }

  InputDecoration decorateTextInput({required String hintText}) {
    return InputDecoration(
      filled: true,
      fillColor: miLightGreyColor,
      focusedBorder: buildOutlineInputBorder(focused: true),
      border: buildOutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(
        horizontal: miDefaultSize * 1.43,
        vertical: miDefaultSize * 2,
      ),
      hintText: hintText,
      hintStyle: TextStyle(fontSize: miDefaultSize * 1.35),
    );
  }
}
