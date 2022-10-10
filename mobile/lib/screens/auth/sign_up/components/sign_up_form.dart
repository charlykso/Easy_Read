import 'package:easy_read/providers/guest_notifier.dart';
import 'package:easy_read/providers/loading_notifier.dart';
import 'package:easy_read/services/auth_service.dart';
import 'package:easy_read/services/dialog_helper.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/shared/util/my_primary_button.dart';
import 'package:easy_read/shared/util/my_text_input_field.dart';
import 'package:easy_read/shared/util/toggle_auth_screen.dart';
import 'package:easy_read/shared/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class SignUpForm extends ConsumerWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guestNotifier = ref.watch(guestProvider.notifier);
    final guestState = ref.watch(guestProvider);
    final formKey = GlobalKey<FormState>();
    Validator validator = Validator();
    void goNamed(
      String name, {
      Map<String, String> params = const <String, String>{},
      Map<String, dynamic> queryParams = const <String, dynamic>{},
      Object? extra,
    }) =>
        context.goNamed(name, params: params, queryParams: queryParams);

    void submitSignUpForm() async {
      if (formKey.currentState!.validate()) {
        final loadingNotifier = ref.watch(loadingProvider.notifier);

        loadingNotifier.turnOn();
        Result result = await guestNotifier.requestVerificationCodeFromApi();

        loadingNotifier.turnOff();
        if (result.status == ResultStatus.success) {
          //* Debugging -----------------------------------------------|
          // && result.data.contains(RegExp(r"^[0-9]{6}$")
          guestState.verificationCode = '123456';
          // guestState.verificationCode = result.data;
          //* ---------------------------------------------------------|

          goNamed('verification');
        } else {
          DialogHelper.showErrorDialog(
              context: context, description: result.data);
        }
      }
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          MyTextInputField(
            hintText: 'First Name',
            keyboardType: TextInputType.name,
            onChanged: (String value) => guestState.firstName = value.trim(),
            validator: validator.validateName,
          ),
          MyTextInputField(
            hintText: 'Last Name',
            keyboardType: TextInputType.name,
            onChanged: (String value) => guestState.lastName = value.trim(),
            validator: validator.validateName,
          ),
          MyTextInputField(
            hintText: 'Your Email',
            keyboardType: TextInputType.emailAddress,
            onChanged: (String value) => guestState.emailAddress = value.trim(),
            validator: validator.validateEmail,
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
              ),
            ),
          ),
          MyTextInputField(
            hintText: 'Password',
            keyboardType: TextInputType.text,
            obscureText: true,
            onChanged: (String value) => guestState.password = value,
            validator: validator.validatePassword,
          ),
          MyPrimaryButton(
            text: 'Continue',
            width: double.infinity,
            press: submitSignUpForm,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: myDefaultSize),
            child: ToggleAuthScreen(
              statement: "I have an account. ",
              action: "Sign In",
              onTap: () => context.goNamed('login'),
            ),
          ),
        ],
      ),
    );
  }
}
