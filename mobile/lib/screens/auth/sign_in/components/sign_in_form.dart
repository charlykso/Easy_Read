import 'package:flutter/material.dart';

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
            MiTextInputField(
              hintText: 'Email Address',
              textInputType: TextInputType.emailAddress,
            ),
            MiTextInputField(
              hintText: 'Password',
              textInputType: TextInputType.text,
              obscureText: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: miDefaultSize),
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
                                BorderRadius.circular(miDefaultSize * 0.5),
                          ),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                        ),
                      ),
                      SizedBox(width: miDefaultSize * 0.5),
                      Text(
                        'Stay Logged In',
                        style: TextStyle(
                          fontSize: size.width > 360
                              ? miDefaultSize
                              : miDefaultSize * 0.8,
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
                            ? miDefaultSize
                            : miDefaultSize * 0.8,
                        color: Colors.black.withOpacity(.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: miDefaultSize * 1.5),
              child: MiPrimaryButton(
                text: 'Sign In',
                bgColor: Colors.transparent,
                press: () {},
                height: miDefaultSize * 5,
                width: size.width,
              ),
            ),
          ],
        ));
  }
}
