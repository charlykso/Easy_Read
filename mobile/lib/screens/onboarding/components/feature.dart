import 'package:flutter/material.dart';

import '../../../shared/constants.dart';

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
            color: miDarkColor,
            fontSize: miDefaultSize * 2,
          ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: miDefaultSize),
          child: Text(
            description,
            style: themeData.textTheme.headline3!.copyWith(
              color: miPrimaryColor,
              fontSize: miDefaultSize * 1.3,
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
