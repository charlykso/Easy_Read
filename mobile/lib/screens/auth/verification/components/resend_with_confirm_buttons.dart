import 'package:easy_read/providers/guest_notifier.dart';
import 'package:easy_read/screens/auth/verification/components/custom_button.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResendWithConfirmButtons extends ConsumerWidget {
  const ResendWithConfirmButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final guestState = ref.watch(guestNotifierProvider);
    final guestNotifier = ref.watch(guestNotifierProvider.notifier);
    void resendCode() async {
      dynamic result = await guestNotifier.requestVerificationCodeFromApi();

      if (result != null && result.contains(RegExp(r"^[0-9]{6}$"))) {
        guestState.verificationCode = result;
        guestNotifier.resetOnResend();
        "New Verification code is ${guestState.verificationCode}".log();
      } else {
        //TODO: Handle errors properly
        "$result".log();
      }
    }

    String resendButtonText = "Resend";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AnimatedCrossFade(
          firstChild: Padding(
            padding: const EdgeInsets.only(bottom: myDefaultSize * .1),
            child: CustomButton(
              //- Disabled resend Button
              text: resendButtonText,
              press: null,
            ),
          ),
          secondChild: Padding(
            padding: const EdgeInsets.only(bottom: myDefaultSize * .1),
            child: CustomButton(
              //- Enabled resend button
              text: resendButtonText,
              press: resendCode,
            ),
          ),
          crossFadeState: guestState.canResend
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: myAnimationDuration,
        ),
        SizedBox(width: size.width * 0.08),
        CustomButton(
          text: "Confirm",
          press: () {
            if (guestState.verificationCode == guestState.inputCode) {
              //- At the end, clear temp user state
              // guestNotifier.reset();
              // "After reset guest state fn is\n${guestState.firstName}".log();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: myAnimationDuration * 4,
                  backgroundColor: myPrimaryColor,
                  content: const Text('Correct OTP!'),
                ),
              );
            } else {
              "User input is - ${guestState.inputCode}".log();
              "verification code is ${guestState.verificationCode}".log();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: myAnimationDuration * 4,
                  backgroundColor: Colors.red[700],
                  content: const Text('Incorrect code supplied!'),
                ),
              );
            }
          },
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
        )
      ],
    );
  }
}
