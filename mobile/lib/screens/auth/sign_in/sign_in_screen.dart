import 'package:easy_read/shared/util/plain_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:easy_read/screens/auth/sign_in/components/body.dart';

class SignInScreen extends StatelessWidget {
  /// For users to sign in to the app
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: plainAppBar(context: context),
      body: const Body(),
    );
  }
}
