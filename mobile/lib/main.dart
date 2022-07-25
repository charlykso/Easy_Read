import 'dart:io';

import 'package:easy_read/screens/welcome_screen.dart';
import 'package:easy_read/shared/my_http_overrides.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_read/shared/helpers.dart'
    show myErrorColor, myPrimaryColor, myTextColor;

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Read',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: myPrimaryColor,
        primarySwatch: Colors.green,
        useMaterial3: true,
        textTheme: GoogleFonts.robotoTextTheme().apply(bodyColor: myTextColor),
        errorColor: myErrorColor,
      ),
      home: const WelcomeScreen(),
    );
  }
}
