import 'package:easy_read/shared/animation/countdown_transition.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';

class ResendTimer extends StatefulWidget {
  const ResendTimer({Key? key}) : super(key: key);

  @override
  State<ResendTimer> createState() => _ResendTimerState();
}

class _ResendTimerState extends State<ResendTimer>
    with TickerProviderStateMixin {
  late AnimationController controller;
  int waitTime = 60;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: waitTime),
      vsync: this,
    );
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Resend code after',
          style: theme.textTheme.bodyText1,
        ),
        const SizedBox(width: myDefaultSize * 0.4),
        CountdownTransition(
          animation: StepTween(begin: waitTime, end: 0).animate(controller),
        ),
      ],
    );
  }
}
