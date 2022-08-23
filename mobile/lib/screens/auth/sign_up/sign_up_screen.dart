import 'package:easy_read/screens/auth/sign_up/components/body.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/shared/util/auth_screen_backgound.dart';
import 'package:easy_read/shared/util/plain_app_bar.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  /// For users to create an account
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myPrimaryColor,
      appBar: plainAppBar(
        surfaceTintColor: myPrimaryColor,
        context: context,
        hasLeadingBackButton: false,
      ),
      body: const AuthScreenBackground(
        child: Body(),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
