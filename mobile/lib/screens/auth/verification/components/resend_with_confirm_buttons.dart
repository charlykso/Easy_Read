import 'package:easy_read/providers/guest_notifier.dart';
import 'package:easy_read/screens/auth/verification/components/custom_button.dart';
import 'package:easy_read/screens/home/home_screen.dart';
import 'package:easy_read/services/dialog_helper.dart';
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
      } else {
        DialogHelper.showErrorDialog(context: context, description: result);
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
          crossFadeState: guestState.canResend!
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: myAnimationDuration,
        ),
        SizedBox(width: size.width * 0.08),
        CustomButton(
          text: "Confirm",
          press: () async {
            if (guestNotifier.validateVerificationCode()) {
              // Sign user in using the api
              String? result = await guestNotifier.signUserUp();

              if (result!.contains(RegExp(r"^error"))) {
                DialogHelper.showErrorDialog(
                    context: context, description: result.substring(0, 5));
              } else {
                //TODO: Save the token permanently on the device
                //TODO: Fetch user details

                // navigate to home screen
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }

              //- At the end, clear temp user state
              guestNotifier.reset();
            } else {
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
