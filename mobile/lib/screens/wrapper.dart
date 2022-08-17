import 'package:easy_read/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return either home or onboarding screen
    return const OnboardingScreen();
  }
}
