import 'package:easy_read/screens/auth/sign_up/sign_up_screen.dart';
import 'package:easy_read/shared/helpers.dart' show myPrimaryColor;
import 'package:easy_read/shared/util/plain_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:easy_read/screens/auth/sign_in/components/body.dart';

class SignInScreen extends StatelessWidget {
  /// For users to sign in to the app
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: plainAppBar(
        context: context,
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            ),
            icon: const Icon(Icons.account_circle_rounded),
            label: Text(
              "Sign Up",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: myPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
        hasLeadingBackButton: false,
      ),
      body: const Body(),
    );
  }
}
