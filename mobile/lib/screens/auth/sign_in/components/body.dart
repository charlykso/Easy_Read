import 'package:flutter/material.dart';

import '../../../../shared/constants.dart';
import 'sign_in_form.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: miDefaultSize * 2),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: miDefaultSize * 1.7),
                child: Text(
                  'Sign In',
                  style: themeData.textTheme.headline3!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: miDefaultSize * 1.7),
                child: SignInForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
