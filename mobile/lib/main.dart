import 'package:easy_read/screens/onboarding/onboarding_screen.dart';
import 'package:easy_read/shared/constants.dart';
import 'package:easy_read/shared/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Read',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: const OnboardingScreen(),
      initialRoute: OnboardingScreen.routeName,
      routes: routes,
    );
  }
}
