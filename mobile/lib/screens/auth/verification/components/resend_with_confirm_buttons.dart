import 'package:easy_read/screens/auth/verification/components/custom_button.dart';
import 'package:flutter/material.dart';

class ResendWithConfirmButtons extends StatelessWidget {
  const ResendWithConfirmButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const CustomButton(
          text: "Resend",
          press: null,
        ),
        SizedBox(width: size.width * 0.08),
        CustomButton(
          text: "Confirm",
          press: () {},
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
        )
      ],
    );
  }
}
