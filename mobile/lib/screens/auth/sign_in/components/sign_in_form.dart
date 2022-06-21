import 'package:flutter/material.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/shared/util/my_primary_button.dart';
import 'package:easy_read/shared/util/my_text_input_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool stayLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
        key: _formKey,
        child: Column(
          children: [
            MyTextInputField(
              hintText: 'Email Address or Phone Number',
              onChanged: (String value) => setState(() => email = value),
              textInputType: TextInputType.text,
              validator: (String? val) =>
                  val!.isEmpty ? 'Enter email or phone number' : null,
            ),
            MyTextInputField(
              hintText: 'Password',
              textInputType: TextInputType.text,
              obscureText: true,
              onChanged: (String value) => setState(() => password = value),
              validator: validatePassword,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: myDefaultSize),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Transform.scale(
                        scale: 2.3,
                        child: Checkbox(
                          value: stayLoggedIn,
                          onChanged: (bool? value) =>
                              setState(() => stayLoggedIn = value!),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(myDefaultSize * 0.5),
                          ),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                        ),
                      ),
                      const SizedBox(width: myDefaultSize * 0.5),
                      Text(
                        'Stay Logged In',
                        style: TextStyle(
                          fontSize: size.width > 360
                              ? myDefaultSize
                              : myDefaultSize * 0.8,
                          color: Colors.black.withOpacity(.6),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Your Password?',
                      style: TextStyle(
                        fontSize: size.width > 360
                            ? myDefaultSize
                            : myDefaultSize * 0.8,
                        color: Colors.black.withOpacity(.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: myDefaultSize * 1.5),
              child: MyPrimaryButton(
                text: 'Sign In',
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
