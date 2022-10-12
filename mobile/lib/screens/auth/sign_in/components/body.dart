import 'package:flutter/material.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/screens/auth/sign_in/components/sign_in_form.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: myDefaultSize * 1.3),
              child: Text(
                'Sign In',
                style: themeData.textTheme.headline3!.copyWith(
                  color: myPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: myDefaultSize * 1.6),
              child: SignInForm(),
            ),
          ],
        ),
      ),
    );
  }
}
