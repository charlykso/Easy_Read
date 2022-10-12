import 'package:easy_read/providers/loading_notifier.dart';
import 'package:easy_read/providers/user_state.dart';
import 'package:easy_read/services/auth_service.dart';
import 'package:easy_read/services/dialog_helper.dart';
import 'package:easy_read/shared/util/social_media_icon.dart';
import 'package:easy_read/shared/util/toggle_auth_screen.dart';
import 'package:easy_read/shared/validator.dart';
import 'package:flutter/material.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/shared/util/my_primary_button.dart';
import 'package:easy_read/shared/util/my_text_input_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class SignInForm extends ConsumerStatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInFormState();
}

enum SocialServices { google, facebook }

class _SignInFormState extends ConsumerState<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  late PhoneNumber phoneNumber;
  late String password;
  final AuthService _authService = AuthService();
  final Validator _validator = Validator();

  @override
  Widget build(BuildContext context) {
    final loadingNotifier = ref.read(loadingProvider.notifier);
    final userNotifier = ref.read(userProvider.notifier);

    /// Login using the appropriate api
    interactWithApis(SocialServices? socialServices) async {
      Result? result;
      loadingNotifier.turnOn();

      switch (socialServices) {
        case SocialServices.google:
          result = await _authService.signInWithGoogle(ref);
          break;
        case SocialServices.facebook:
          result = await _authService.signInWithFacebook(ref);
          break;
        default:
          // not using any social service
          if (_formKey.currentState!.validate()) {
            result = await _authService.signInWithPhoneNumberAndPassWord(
                phoneNumber: phoneNumber.completeNumber, password: password);
          }
      }

      loadingNotifier.turnOff();
      if (result != null) {
        if (result.status == ResultStatus.success) {
          userNotifier.saveCurrentUser(userInfo: result.data);
        } else {
          DialogHelper.showErrorDialog(
              context: context, description: result.data);
        }
      }
    }

    return Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: myDefaultSize * 1.4),
              child: Material(
                elevation: 10.0,
                shadowColor: Colors.black54,
                borderRadius: BorderRadius.circular(myDefaultSize * .8),
                child: IntlPhoneField(
                  decoration: decorateTextInput(hintText: "Phone Number")
                      .copyWith(errorMaxLines: 1),
                  onChanged: (PhoneNumber phone) => phoneNumber = phone,
                  initialCountryCode: "NG",
                ),
              ),
            ),
            MyTextInputField(
              hintText: 'Password',
              keyboardType: TextInputType.text,
              obscureText: true,
              onChanged: (String value) => setState(() => password = value),
              validator: _validator.validatePassword,
            ),
            MyPrimaryButton(
              text: 'Continue',
              width: double.infinity,
              press: () => interactWithApis(null),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: myDefaultSize,
                bottom: myDefaultSize * .7,
              ),
              child: ToggleAuthScreen(
                statement: "I don't have an account yet. ",
                action: "Sign Up",
                onTap: () => context.goNamed('register'),
              ),
            ),
            Text(
              "Sign in with",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: myDefaultSize * .5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialMediaIcon(
                    imagePath: 'assets/icons/google_rounded.svg',
                    tap: () => interactWithApis(SocialServices.google),
                    color: Colors.red,
                  ),
                  const SizedBox(width: myDefaultSize * 1.5),
                  SocialMediaIcon(
                    imagePath: 'assets/icons/facebook.svg',
                    tap: () => interactWithApis(SocialServices.facebook),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
