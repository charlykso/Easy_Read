import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_read/shared/helpers.dart';

class MyTextInputField extends StatelessWidget {
  /// A custom text input widget
  const MyTextInputField({
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
      padding: const EdgeInsets.symmetric(vertical: myDefaultSize),
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
      borderRadius: BorderRadius.circular(myDefaultSize * 1.43),
      borderSide:
          focused ? const BorderSide(color: myPrimaryColor) : BorderSide.none,
    );
  }

  InputDecoration decorateTextInput({required String hintText}) {
    return InputDecoration(
      filled: true,
      fillColor: myLightGreyColor,
      focusedBorder: buildOutlineInputBorder(focused: true),
      border: buildOutlineInputBorder(),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: myDefaultSize * 1.43,
        vertical: myDefaultSize * 2,
      ),
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: myDefaultSize * 1.35),
    );
  }
}
