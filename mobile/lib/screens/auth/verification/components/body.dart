import 'package:easy_read/providers/guest_notifier.dart';
import 'package:easy_read/screens/auth/sign_up/sign_up_screen.dart';
import 'package:easy_read/screens/auth/verification/components/code_input_field.dart';
import 'package:easy_read/screens/auth/verification/components/resend_timer.dart';
import 'package:easy_read/screens/auth/verification/components/resend_with_confirm_buttons.dart';
import 'package:easy_read/shared/helpers.dart' show Log, myDefaultSize;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Body extends ConsumerWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final guestNotifier = ref.watch(guestNotifierProvider.notifier);
    final guestState = ref.watch(guestNotifierProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: myDefaultSize * 1.17,
        vertical: myDefaultSize * 1.17,
      ),
      child: Stack(
        children: [
          Column(
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
                  Text(
                    guestState.phoneNumber!.completeNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen())),
                    child: const Text("Change phone number?"),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: myDefaultSize * 1.7),
                child: Form(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      6,
                      (index) => CodeInputField(index: index),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: myDefaultSize * .6),
              const ResendTimer(),
            ],
          ),
          const Positioned(
            bottom: 0,
            child: ResendWithConfirmButtons(),
          ),
        ],
      ),
    );
  }
}
