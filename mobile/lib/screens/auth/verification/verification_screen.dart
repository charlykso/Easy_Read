import 'package:easy_read/screens/auth/verification/components/body.dart';
import 'package:easy_read/shared/util/plain_app_bar.dart';
import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: plainAppBar(context: context),
      body: const Body(),
    );
  }
}
