import 'package:flutter/material.dart';

import '../../../shared/helpers.dart';

class Feature extends StatelessWidget {
  /// The `Feature` widget displays a feature
  /// of the app on the
  /// onboarding screen

  const Feature({
    Key? key,
    required this.text,
    required this.description,
    required this.image,
  }) : super(key: key);

  final String text, description, image;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        const Spacer(flex: 3),
        Text(
          text,
          style: themeData.textTheme.headline1!.copyWith(
            color: mySecondaryColor,
            fontSize: myDefaultSize * 2,
          ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: myDefaultSize),
          child: Text(
            description,
            style: themeData.textTheme.headline3!.copyWith(
              color: myPrimaryColor,
              fontSize: myDefaultSize * 1.3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(flex: 3),
        Image.asset(
          image,
          height: size.width * 0.52,
        ),
      ],
    );
  }
}
