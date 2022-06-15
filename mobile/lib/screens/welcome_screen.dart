import 'package:easy_read/screens/auth/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';

import '../shared/constants.dart';
import '../shared/util/mi_primary_button.dart';
import 'auth/sign_in/sign_in_screen.dart';

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
              Spacer(),
              Text(
                'Get Started',
                style: themeData.textTheme.headline1!.copyWith(
                  color: miDarkColor,
                  fontSize: miDefaultSize * 2.2,
                ),
              ),
              Spacer(),
              Image.asset(
                'assets/images/reading.png',
                width: size.width,
                height: size.height * 0.4,
              ),
              Spacer(flex: 2),
              MiPrimaryButton(
                text: 'Create account',
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SignUpScreen()),
                ),
              ),
              SizedBox(height: miDefaultSize),
              MiPrimaryButton(
                text: 'Sign In',
                bgColor: Colors.transparent,
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SignInScreen(),
                  ),
                ),
              ),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
