import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../shared/helpers.dart';
import '../../../../shared/util/my_primary_button.dart';
import '../../../../shared/util/my_text_input_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNumber = '';
  String password = '';
  bool stayLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            MyTextInputField(
              hintText: 'First Name',
              textInputType: TextInputType.name,
              onChanged: (String value) => setState(() => firstName = value),
              validator: (String? val) =>
                  val!.isEmpty ? 'Enter your first name' : null,
            ),
            MyTextInputField(
              hintText: 'Last Name',
              textInputType: TextInputType.name,
              onChanged: (String value) => setState(() => lastName = value),
              validator: (String? val) =>
                  val!.isEmpty ? 'Enter your last name' : null,
            ),
            MyTextInputField(
              hintText: 'Email Address',
              textInputType: TextInputType.emailAddress,
              onChanged: (String value) => setState(() => email = value),
              validator: (String? val) =>
                  val!.isEmpty ? 'Enter an email' : null,
            ),
            MyTextInputField(
              hintText: 'Phone number',
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9+]')),
              ],
              textInputType: TextInputType.number,
              onChanged: (String value) => setState(() => phoneNumber = value),
              validator: (String? val) =>
                  val!.isEmpty ? 'Enter phone number' : null,
            ),
            MyTextInputField(
              hintText: 'Password',
              textInputType: TextInputType.text,
              obscureText: true,
              onChanged: (String value) => setState(() => password = value),
              validator: validatePassword,
            ),
            Padding(
              padding: const EdgeInsets.only(top: myDefaultSize * 2.2),
              child: MyPrimaryButton(
                text: 'Sign Up',
                bgColor: Colors.transparent,
                press: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Valid',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: myPrimaryColor,
                      ),
                    );
                  }
                },
                height: myDefaultSize * 5,
                width: double.infinity,
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
