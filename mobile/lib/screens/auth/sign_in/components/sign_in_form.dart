import 'package:easy_read/screens/auth/sign_up/sign_up_screen.dart';
import 'package:easy_read/screens/home/home_screen.dart';
import 'package:easy_read/services/auth_service.dart';
import 'package:easy_read/shared/util/social_media_icon.dart';
import 'package:easy_read/shared/util/toggle_auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/shared/util/my_primary_button.dart';
import 'package:easy_read/shared/util/my_text_input_field.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  late NavigatorState _navigator;

  final _formKey = GlobalKey<FormState>();
  String phoneNumber = '';
  String password = '';
  AuthService authService = AuthService();

  @override
  void didChangeDependencies() {
    _navigator = Navigator.of(context);
    super.didChangeDependencies();
  }

  signInWithFacebook() async {
    final String? user = await authService.signInWithFacebook();

    // TODO: Implement this auto with riverpod
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: myAnimationDuration * 3,
          backgroundColor: Colors.red[700],
          content: const Text('Unable to sign in!'),
        ),
      );
    } else {
      "$user is ready!".log();
      _navigator.pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }

  signInWithGoogle() async {
    final user = await authService.signInWithGoogle();

    // TODO: Implement this auto with riverpod
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: myAnimationDuration * 3,
          backgroundColor: Colors.red[700],
          content: const Text('Unable to sign in!'),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                  onChanged: (PhoneNumber phone) =>
                      phoneNumber = phone.completeNumber,
                  initialCountryCode: "NG",
                ),
              ),
            ),
            MyTextInputField(
              hintText: 'Password',
              keyboardType: TextInputType.text,
              obscureText: true,
              onChanged: (String value) => setState(() => password = value),
            ),
            MyPrimaryButton(
              text: 'Continue',
              width: double.infinity,
              press: () {
                if (phoneNumber.trim().isEmpty || password.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: myAnimationDuration,
                      content: const Text(
                        'Invalid email address or password',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.red[700],
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: myAnimationDuration,
                      content: Text(
                        'It\'s valid for now!',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: myPrimaryColor,
                    ),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: myDefaultSize,
                bottom: myDefaultSize * .7,
              ),
              child: ToggleAuthScreen(
                statement: "I don't have an account yet. ",
                action: "Sign Up",
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SignUpScreen(),
                  ),
                ),
              ),
            ),
            Text(
              "Sign in with",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: myDefaultSize * .5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialMediaIcon(
                    imagePath: 'assets/icons/google-plus.svg',
                    tap: signInWithGoogle,
                    color: Colors.red,
                    backgroundColor: Colors.white,
                  ),
                  SocialMediaIcon(
                    imagePath: 'assets/icons/facebook.svg',
                    tap: signInWithFacebook,
                    color: Colors.white,
                    backgroundColor: Colors.blue[700],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
