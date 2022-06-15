import 'package:flutter/material.dart';

import '../../../shared/constants.dart';
import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  /// For users to create an account
  const SignUpScreen({Key? key}) : super(key: key);

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
