import 'package:flutter/material.dart';
import 'package:easy_read/screens/onboarding/components/body.dart';

class OnboardingScreen extends StatelessWidget {
  /// Introduces the app features
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
