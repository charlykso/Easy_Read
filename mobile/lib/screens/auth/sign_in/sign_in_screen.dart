import 'package:flutter/material.dart';

import '../../../shared/helpers.dart';
import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  /// For users to sign in to the app
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: myPrimaryColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.white,
      ),
      body: const Body(),
    );
  }
}
