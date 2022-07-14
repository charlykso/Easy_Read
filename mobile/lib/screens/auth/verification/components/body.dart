import 'package:easy_read/screens/auth/verification/components/form_field_with_timer.dart';
import 'package:easy_read/screens/auth/verification/components/resend_with_confirm_buttons.dart';
import 'package:easy_read/shared/helpers.dart' show myDefaultSize;
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: myDefaultSize * 1.17,
        vertical: myDefaultSize * 1.17,
      ),
      child: Stack(
        children: const [
          FormFieldWithTimer(),
          Positioned(
            bottom: 0,
            child: ResendWithConfirmButtons(),
          ),
        ],
      ),
    );
  }
}
