import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../shared/constants.dart';
import '../../../../shared/util/mi_primary_button.dart';
import '../../../../shared/util/mi_text_input_field.dart';

/// Fancy extension to simplfy [MaterialState] calls
extension MaterialStateSet on Set<MaterialState> {
  bool get hasError => contains(MaterialState.error);
  bool get isSelected => contains(MaterialState.selected);
}

Color? getColor(Set<MaterialState> states) {
  if (states.hasError) {
    return Colors.red;
  } else if (states.isSelected) {
    return miPrimaryColor;
  }
  return Colors.grey.withOpacity(.4);
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String first_name = '';
  String last_name = '';
  String email = '';
  String phone_number = '';
  String password = '';
  bool stayLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
        key: _formKey,
        child: Column(
          children: [
            MiTextInputField(
              hintText: 'First Name',
              textInputType: TextInputType.name,
              onChanged: (String value) => setState(() => first_name = value),
              validator: (String? val) =>
                  val!.isEmpty ? 'Enter your first name' : null,
            ),
            MiTextInputField(
              hintText: 'Last Name',
              textInputType: TextInputType.name,
              onChanged: (String value) => setState(() => last_name = value),
              validator: (String? val) =>
                  val!.isEmpty ? 'Enter your last name' : null,
            ),
            MiTextInputField(
              hintText: 'Email Address',
              textInputType: TextInputType.emailAddress,
              onChanged: (String value) => setState(() => email = value),
              validator: (String? val) =>
                  val!.isEmpty ? 'Enter an email' : null,
            ),
            MiTextInputField(
              hintText: 'Phone number',
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9+]')),
              ],
              textInputType: TextInputType.number,
              onChanged: (String value) => setState(() => phone_number = value),
              validator: (String? val) =>
                  val!.isEmpty ? 'Enter phone number' : null,
            ),
            MiTextInputField(
              hintText: 'Password',
              textInputType: TextInputType.text,
              obscureText: true,
              onChanged: (String value) => setState(() => password = value),
              validator: validatePassword,
            ),
            Padding(
              padding: const EdgeInsets.only(top: miDefaultSize * 2.2),
              child: MiPrimaryButton(
                text: 'Sign Up',
                bgColor: Colors.transparent,
                press: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Valid',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: miPrimaryColor,
                      ),
                    );
                  }
                },
                height: miDefaultSize * 5,
                width: size.width,
              ),
            ),
          ],
        ));
  }

  String? validatePassword(String? val) {
    if (val!.isEmpty) {
      return 'Must be more than 6 characters\nMust contain at least one uppercase letter\nMust have at least one number';
    } else if (val.length < 6) {
      return 'Must be more than 6 characters';
    } else if (!val.contains(RegExp(r'[A-Z]'))) {
      return 'Must contain at least one uppercase letter';
    } else if (!val.contains(RegExp(r'[0-9]'))) {
      return 'Must have at least one number';
    }

    return '';
  }
}
