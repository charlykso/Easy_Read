import 'package:easy_read/providers/guest_notifier.dart';
import 'package:easy_read/screens/auth/verification/verification_screen.dart';
import 'package:easy_read/services/dialog_helper.dart';
import 'package:easy_read/shared/util/my_winged_divider.dart';
import 'package:easy_read/shared/util/social_media_icon.dart';
import 'package:easy_read/shared/validator.dart';
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
            hintText: 'Email Address',
            keyboardType: TextInputType.emailAddress,
            onChanged: (String value) => guestState.emailAddress = value,
            validator: validator.validateEmail,
            initialValue: guestState.emailAddress,
          ),
          IntlPhoneField(
            decoration: decorateTextInput(hintText: "Phone Number"),
            onChanged: (PhoneNumber phone) => guestState.phoneNumber = phone,
            initialCountryCode: "NG",
            validator: (PhoneNumber? value) =>
                validator.validatePhoneNumber(value?.completeNumber),
            initialValue: guestState.phoneNumber?.number,
          ),
          MyTextInputField(
            hintText: 'Password',
            keyboardType: TextInputType.text,
            obscureText: true,
            onChanged: (String value) => guestState.password = value,
            validator: validator.validatePassword,
            initialValue: guestState.password,
          ),
          Padding(
            padding: const EdgeInsets.only(top: myDefaultSize * 2.2),
            child: MyPrimaryButton(
              text: 'Sign Up',
              press: () async {
                if (formKey.currentState!.validate()) {
                  dynamic result =
                      await guestNotifier.requestVerificationCodeFromApi();

                  if (result != null &&
                      result.contains(RegExp(r"^[0-9]{6}$"))) {
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
      ),
    );
  }
}
