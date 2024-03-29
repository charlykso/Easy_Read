import 'package:easy_read/providers/guest_notifier.dart';
import 'package:easy_read/providers/loading_notifier.dart';
import 'package:easy_read/providers/user_state.dart';
import 'package:easy_read/screens/auth/verification/components/custom_button.dart';
import 'package:easy_read/services/auth_service.dart';
import 'package:easy_read/services/dialog_helper.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResendWithConfirmButtons extends ConsumerWidget {
  const ResendWithConfirmButtons({
    Key? key,
    required this.restartCountdownAnimation,
  }) : super(key: key);

  final Function() restartCountdownAnimation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final guestState = ref.watch(guestProvider);
    final guestNotifier = ref.watch(guestProvider.notifier);
    final userNotifier = ref.watch(userProvider.notifier);
    final loadingNotifier = ref.watch(loadingProvider.notifier);
    String resendButtonText = "Resend";
    final authService = AuthService();

    void resendCode() async {
      loadingNotifier.turnOn();

      Result result = await authService.getVerificationCode(
        phoneNumber: guestState.phoneNumber!.completeNumber,
      );

      loadingNotifier.turnOff();
      if (result.status == ResultStatus.success) {
        guestState.verificationCode = result.data;
        guestNotifier.setCanResend(value: false);
        restartCountdownAnimation();
      } else {
        DialogHelper.showErrorDialog(
            context: context, description: result.data);
      }
    }

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
              loadingNotifier.turnOn();
              Result result =
                  await authService.signUpWithPhoneNumberAndPassword(
                userData: {
                  "firstname": guestState.firstName,
                  "lastname": guestState.lastName,
                  "email": guestState.emailAddress,
                  "phone_no": guestState.phoneNumber!.completeNumber,
                  "password": guestState.password
                },
              );

              loadingNotifier.turnOff();
              if (result.status == ResultStatus.error) {
                DialogHelper.showErrorDialog(
                    context: context, description: result.data);
              } else {
                // Clear temp user state
                guestNotifier.reset();

                // Save the details on the device
                userNotifier.saveCurrentUser(userInfo: result.data);
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
