import 'package:easy_read/screens/auth/verification/components/resend_timer.dart';
import 'package:easy_read/screens/auth/verification/components/verification_form.dart';
import 'package:easy_read/shared/helpers.dart' show myDefaultSize;
import 'package:flutter/material.dart';

class FormFieldWithTimer extends StatelessWidget {
  const FormFieldWithTimer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Verify Mobile Number",
          style: theme.textTheme.headline4?.copyWith(
            color: Colors.black,
          ),
        ),
        const Text(
          "Enter the code sent to",
          style: TextStyle(
            fontSize: myDefaultSize * 1.3,
          ),
        ),
        Row(
          children: [
            const Text(
              "+234******4254",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Change phone number?"),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: myDefaultSize * 1.7),
          child: VerificationForm(),
        ),
        const SizedBox(height: myDefaultSize * .6),
        const ResendTimer(),
      ],
    );
  }
}
