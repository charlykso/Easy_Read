import 'package:flutter/material.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/screens/auth/sign_up/components/sign_up_form.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: myDefaultSize * 2),
          Padding(
            padding: const EdgeInsets.only(bottom: myDefaultSize),
            child: Text(
              'Sign Up',
              style: themeData.textTheme.headline3!.copyWith(
                color: myPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: myDefaultSize * 1.6),
            child: SignUpForm(),
          ),
        ],
      ),
    );
  }
}
