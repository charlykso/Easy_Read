import 'package:flutter/material.dart';

import 'components/body.dart';

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
