import 'package:easy_read/screens/auth/verification/components/code_input_field.dart';
import 'package:flutter/material.dart';

class VerificationForm extends StatefulWidget {
  const VerificationForm({Key? key}) : super(key: key);

  @override
  State<VerificationForm> createState() => _VerificationFormState();
}

class _VerificationFormState extends State<VerificationForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(6, (index) => const CodeInputField()),
      ),
    );
  }
}
