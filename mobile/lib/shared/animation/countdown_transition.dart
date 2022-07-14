import 'package:easy_read/shared/helpers.dart' show mySecondaryColor;
import 'package:flutter/material.dart';

class CountdownTransition extends AnimatedWidget {
  const CountdownTransition({
    Key? key,
    required this.animation,
  }) : super(key: key, listenable: animation);

  final Animation<int> animation;

  @override
  Widget build(BuildContext context) {
    Duration duration = Duration(seconds: animation.value);
    int seconds = duration.inSeconds;
    String timerText = "${duration.inSeconds.toString()}s";

    return Text(
      timerText,
      style: Theme.of(context).textTheme.bodyText1?.copyWith(
            color: seconds != 0 ? mySecondaryColor : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
