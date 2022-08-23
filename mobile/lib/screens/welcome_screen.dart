import 'package:easy_read/screens/auth/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/shared/util/my_primary_button.dart';
import 'package:easy_read/screens/auth/sign_in/sign_in_screen.dart';

class WelcomeScreen extends StatelessWidget {
  /// This widget takes a user to
  /// any of the auth screens
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                'Get Started',
                style: themeData.textTheme.headline1!.copyWith(
                  color: mySecondaryColor,
                  fontSize: myDefaultSize * 2.2,
                ),
              ),
              const Spacer(),
              Image.asset(
                'assets/images/reading.png',
                width: size.width,
                height: size.height * 0.4,
              ),
              const Spacer(flex: 2),
              MyPrimaryButton(
                text: 'Create account',
                press: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const SignUpScreen()),
                ),
              ),
              const SizedBox(height: myDefaultSize),
              MyPrimaryButton(
                text: 'Sign In',
                backgroundColor: Colors.transparent,
                press: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const SignInScreen(),
                  ),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
