import 'package:easy_read/providers/loading_notifier.dart';
import 'package:easy_read/screens/auth/verification/components/filled_rounded_pin_put.dart';
import 'package:easy_read/services/auth_service.dart';
import 'package:easy_read/services/dialog_helper.dart';
import 'package:easy_read/shared/animation/countdown_transition.dart';
import 'package:easy_read/shared/loading_widget.dart';
import 'package:easy_read/shared/util/plain_app_bar.dart';
import 'package:easy_read/providers/guest_notifier.dart';
import 'package:easy_read/screens/auth/verification/components/resend_with_confirm_buttons.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/shared/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class VerificationScreen extends ConsumerStatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  VerificationScreenState createState() => VerificationScreenState();
}

class VerificationScreenState extends ConsumerState<VerificationScreen>
    with TickerProviderStateMixin {
  int waitTime = 60;
  late AnimationController countdownController;

  _modifyPhoneNumber(BuildContext context, bool isLoading) async {
    final guestState = ref.watch(guestProvider);

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Change phone number'),
        content: isLoading
            ? const LoadingWidget()
            : IntlPhoneField(
                decoration: decorateTextInput(hintText: "Phone Number")
                    .copyWith(
                        border: null, focusedBorder: null, errorBorder: null),
                onChanged: (PhoneNumber phone) =>
                    guestState.phoneNumber = phone,
                initialCountryCode: "NG",
                validator: (PhoneNumber? value) =>
                    Validator().validatePhoneNumber(value?.completeNumber),
                initialValue: guestState.phoneNumber?.number,
              ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 0, vertical: myDefaultSize * .6),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final guestNotifier = ref.watch(guestProvider.notifier);
              final loadingNotifier = ref.watch(loadingProvider.notifier);

              loadingNotifier.turnOn();
              Result result =
                  await guestNotifier.requestVerificationCodeFromApi();

              loadingNotifier.turnOff();
              if (result.status == ResultStatus.success) {
                guestState.verificationCode = result.data;
                guestNotifier.setCanResend(value: false);
                _restartCountdown();

                if (!mounted) return;
                Navigator.pop(context);
              } else {
                DialogHelper.showErrorDialog(
                  context: context,
                  description: result.data,
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  _restartCountdown() {
    countdownController.value = 0.0;
    countdownController.forward();
  }

  @override
  void initState() {
    super.initState();
    countdownController = AnimationController(
      vsync: this,
      duration: Duration(seconds: waitTime),
    );
    countdownController.forward();
  }

  @override
  void dispose() {
    countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final guestState = ref.watch(guestProvider);
    final isLoading = ref.watch(loadingProvider);
    countdownController.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.completed:
          ref.watch(guestProvider.notifier).setCanResend(value: true);
          break;
        default:
      }
    });

    return Scaffold(
      appBar: plainAppBar(
        context: context,
        hasLeadingBackButton: false,
      ),
      body: Padding(
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
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Theme.of(context).primaryColor,
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
                      guestState.phoneNumber?.completeNumber ?? '***********',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () async =>
                          await _modifyPhoneNumber(context, isLoading),
                      child: const Text("Change phone number?"),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: myDefaultSize * 1.7),
                  child:
                      isLoading ? const LoadingWidget() : FilledRoundedPinPut(),
                ),
                const SizedBox(height: myDefaultSize * .6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Resend code after',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(width: myDefaultSize * 0.4),
                    CountdownTransition(
                      animation: StepTween(begin: waitTime, end: 0)
                          .animate(countdownController),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: ResendWithConfirmButtons(
                restartCountdownAnimation: _restartCountdown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
