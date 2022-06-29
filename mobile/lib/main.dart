import 'package:easy_read/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_read/shared/helpers.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Read',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: myPrimaryColor,
        useMaterial3: true,
        textTheme: GoogleFonts.robotoTextTheme().apply(bodyColor: myTextColor),
      ),
      home: const WelcomeScreen(),
    );
  }
}
