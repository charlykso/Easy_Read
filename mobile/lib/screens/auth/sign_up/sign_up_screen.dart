import 'package:easy_read/screens/auth/sign_in/sign_in_screen.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/shared/util/plain_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:easy_read/screens/auth/sign_up/components/body.dart';

class SignUpScreen extends StatelessWidget {
  /// For users to create an account
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: plainAppBar(
        context: context,
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const SignInScreen()),
            ),
            icon: const Icon(Icons.login_rounded),
            label: Text(
              "Login",
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
