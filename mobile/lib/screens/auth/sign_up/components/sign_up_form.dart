import 'package:easy_read/shared/util/my_winged_divider.dart';
import 'package:easy_read/shared/util/social_media_icon.dart';
import 'package:easy_read/shared/validator.dart';
import 'package:flutter/material.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/shared/util/my_primary_button.dart';
import 'package:easy_read/shared/util/my_text_input_field.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final Validator _validator = Validator();

  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            MyTextInputField(
              hintText: 'First Name',
              keyboardType: TextInputType.name,
              onChanged: (String value) => setState(() => firstName = value),
              validator: _validator.validateName,
            ),
            MyTextInputField(
              hintText: 'Last Name',
              keyboardType: TextInputType.name,
              onChanged: (String value) => setState(() => lastName = value),
              validator: _validator.validateName,
            ),
            MyTextInputField(
              hintText: 'Email Address',
              keyboardType: TextInputType.emailAddress,
              onChanged: (String value) => setState(() => email = value),
              validator: _validator.validateEmail,
            ),
            IntlPhoneField(
              decoration: decorateTextInput(hintText: "Phone Number"),
              onChanged: (PhoneNumber phone) =>
                  setState(() => phoneNumber = phone.completeNumber),
              initialCountryCode: "NG",
              disableLengthCheck: true,
            ),
            MyTextInputField(
              hintText: 'Password',
              keyboardType: TextInputType.text,
              obscureText: true,
              onChanged: (String value) => setState(() => password = value),
              validator: _validator.validatePassword,
            ),
            Padding(
              padding: const EdgeInsets.only(top: myDefaultSize * 2.2),
              child: MyPrimaryButton(
                text: 'Sign Up',
                press: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: myAnimationDuration,
                        content: Text(
                          'Valid details',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: mySecondaryColor,
                      ),
                    );
                  }
                },
                height: myDefaultSize * 5,
                width: double.infinity,
              ),
            ),
            const MyWingedDivider(text: 'OR'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SocialMediaIcon(
                  imagePath: 'assets/icons/google-plus.svg',
                  tap: () {},
                ),
                SocialMediaIcon(
                  imagePath: 'assets/icons/facebook.svg',
                  tap: () {},
                ),
              ],
            ),
            const SizedBox(height: myDefaultSize * 2),
          ],
        ));
  }
}
