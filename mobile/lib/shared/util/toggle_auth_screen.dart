import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ToggleAuthScreen extends StatelessWidget {
  const ToggleAuthScreen({
    Key? key,
    required this.statement,
    required this.action,
    this.onTap,
  }) : super(key: key);

  final String? statement, action;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.subtitle2,
        children: [
          TextSpan(
            text: statement ?? "Join Us",
          ),
          TextSpan(
            text: action ?? "Sign Up",
            style: const TextStyle(color: Colors.cyan),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
