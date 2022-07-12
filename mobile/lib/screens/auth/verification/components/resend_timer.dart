import 'package:easy_read/shared/helpers.dart' show mySecondaryColor;
import 'package:flutter/material.dart';

class ResendTimer extends StatelessWidget {
  const ResendTimer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Resend code after ',
                style: theme.textTheme.bodyText1,
              ),
              TextSpan(
                  text: '1:00',
                  style: theme.textTheme.bodyText1?.copyWith(
                    color: mySecondaryColor,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
