import 'package:easy_read/providers/guest_notifier.dart';
import 'package:easy_read/screens/auth/sign_in/sign_in_screen.dart';
import 'package:easy_read/screens/auth/verification/verification_screen.dart';
import 'package:easy_read/services/dialog_helper.dart';
import 'package:easy_read/shared/validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/shared/util/my_primary_button.dart';
import 'package:easy_read/shared/util/my_text_input_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class SignUpForm extends ConsumerWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guestNotifier = ref.watch(guestNotifierProvider.notifier);
    final guestState = ref.watch(guestNotifierProvider);
    final formKey = GlobalKey<FormState>();
    Validator validator = Validator();

    return Form(
      key: formKey,
      child: Column(
        children: [
          MyTextInputField(
            hintText: 'First Name',
            keyboardType: TextInputType.name,
            onChanged: (String value) => guestState.firstName = value,
            validator: validator.validateName,
            initialValue: guestState.firstName,
          ),
          MyTextInputField(
            hintText: 'Last Name',
            keyboardType: TextInputType.name,
            onChanged: (String value) => guestState.lastName = value,
            validator: validator.validateName,
            initialValue: guestState.lastName,
          ),
          MyTextInputField(
            hintText: 'Your Email',
            keyboardType: TextInputType.emailAddress,
            onChanged: (String value) => guestState.emailAddress = value,
            validator: validator.validateEmail,
            initialValue: guestState.emailAddress,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: myDefaultSize * 1.4),
            child: Material(
              elevation: 10.0,
              shadowColor: Colors.black54,
              borderRadius: BorderRadius.circular(myDefaultSize * .8),
              child: IntlPhoneField(
                decoration: decorateTextInput(hintText: "Phone Number")
                    .copyWith(errorMaxLines: 1),
                onChanged: (PhoneNumber phone) =>
                    guestState.phoneNumber = phone,
                initialCountryCode: "NG",
                initialValue: guestState.phoneNumber?.number,
              ),
            ),
          ),
          MyTextInputField(
            hintText: 'Password',
            keyboardType: TextInputType.text,
            obscureText: true,
            onChanged: (String value) => guestState.password = value,
            validator: validator.validatePassword,
            initialValue: guestState.password,
          ),
          MyPrimaryButton(
            text: 'Sign Up',
            width: double.infinity,
            press: () async {
              if (formKey.currentState!.validate()) {
                dynamic result =
                    await guestNotifier.requestVerificationCodeFromApi();

                if (result != null && result.contains(RegExp(r"^[0-9]{6}$"))) {
                  guestState.verificationCode = result;

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VerificationScreen()),
                  );
                } else {
                  DialogHelper.showErrorDialog(
                      context: context, description: result);
                }
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: myDefaultSize),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.subtitle2,
                    children: [
                      const TextSpan(
                        text: "I have an account. ",
                      ),
                      TextSpan(
                        text: "Sign In",
                        style: const TextStyle(color: myPrimaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignInScreen(),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
