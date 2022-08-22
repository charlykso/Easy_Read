import 'package:easy_read/models/feature_info.dart';
import 'package:easy_read/screens/auth/sign_up/sign_up_screen.dart';
import 'package:easy_read/screens/onboarding/components/carousel_dot.dart';
import 'package:easy_read/shared/util/my_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_read/shared/helpers.dart';

class Feature extends StatelessWidget {
  /// The `Feature` widget displays a feature
  /// of the app on the
  /// onboarding screen

  const Feature({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
    required this.currentPage,
  }) : super(key: key);

  final String title, description, image;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Image.asset(
          image,
          height: size.height * 0.5,
          width: size.width,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: myDefaultSize),
          child: Container(
            height: size.height * 0.43,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(0, 7),
                  blurRadius: 8,
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0, 7),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: myDefaultSize),
              child: Column(
                children: [
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      features.length,
                      (_) => CarouselDot(currentPage: currentPage, index: _),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    title.toTitleCase(),
                    style: themeData.textTheme.headline1!.copyWith(
                      fontSize: myDefaultSize * 2,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Text(
                    description.toTitleCase(),
                    style: themeData.textTheme.headline3!.copyWith(
                      fontSize: myDefaultSize * 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  MyPrimaryButton(
                    text: 'Get Started',
                    press: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
