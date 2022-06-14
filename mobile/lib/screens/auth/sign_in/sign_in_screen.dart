import 'package:flutter/material.dart';

import '../../../shared/constants.dart';
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
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: miPrimaryColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.white,
      ),
      body: Body(),
    );
  }
}
