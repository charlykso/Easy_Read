import 'package:easy_read/providers/guest_notifier.dart';
import 'package:easy_read/providers/user_notifier.dart';
import 'package:easy_read/screens/auth/verification/components/custom_button.dart';
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
    final userNotifier = ref.watch(userNotifierProvider.notifier);
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
            logger.i("Before: ${guestState.verificationCode}");
            logger.wtf(guestState.userInputCodes?.join());
            if (guestNotifier.validateVerificationCode()) {
              // Sign user in using the api
              Map? result = await guestNotifier.signUserUp();

              if (result!.containsKey("error")) {
                DialogHelper.showErrorDialog(
                    context: context, description: result["error"]);
                logger.i("After: ${guestState.verificationCode}");
                logger.wtf(guestState.userInputCodes?.join());
              } else {
                // Save the details on the device
                userNotifier.saveCurrentUser();

                // clear temp user state
                guestNotifier.reset();

                // navigate to home screen
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const HomeScreen()));
              }
            } else {
              DialogHelper.showErrorDialog(
                  context: context, description: 'Incorrect code supplied!');
            }
          },
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
        )
      ],
    );
  }
}
