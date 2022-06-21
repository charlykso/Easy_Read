import 'package:flutter/material.dart';

import '../../../../shared/helpers.dart';
import 'sign_up_form.dart';

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
              const SizedBox(height: myDefaultSize * 2),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: myDefaultSize * 1.7),
                child: Text(
                  'Sign Up',
                  style: themeData.textTheme.headline3!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: myDefaultSize * 1.7),
                child: SignUpForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
