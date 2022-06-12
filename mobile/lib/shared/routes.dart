import 'package:easy_read/screens/home/home_screen.dart';
import 'package:easy_read/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

/// Stores all the available routes
final Map<String, WidgetBuilder> routes = {
  OnboardingScreen.routeName: (context) => const OnboardingScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
};
