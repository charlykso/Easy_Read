import 'package:easy_read/providers/guest_notifier.dart';
import 'package:easy_read/shared/animation/countdown_transition.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResendTimer extends ConsumerStatefulWidget {
  const ResendTimer({Key? key}) : super(key: key);

  @override
  ResendTimerState createState() => ResendTimerState();
}

class ResendTimerState extends ConsumerState<ResendTimer>
    with TickerProviderStateMixin {
  int waitTime = 60;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final guestState = ref.watch(guestNotifierProvider);
    guestState.countdownAnimationController = AnimationController(
      duration: Duration(seconds: waitTime),
      vsync: this,
    );
    guestState.countdownAnimationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final guestState = ref.watch(guestNotifierProvider);
    guestState.countdownAnimationController?.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.completed:
          ref.watch(guestNotifierProvider.notifier).setCanResend(value: true);
          break;
        default:
      }
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Resend code after',
          style: theme.textTheme.bodyText1,
        ),
        const SizedBox(width: myDefaultSize * 0.4),
        CountdownTransition(
          animation: StepTween(begin: waitTime, end: 0)
              .animate(guestState.countdownAnimationController!),
        ),
      ],
    );
  }
}
