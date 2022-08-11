import 'package:easy_read/services/dialog_helper.dart';
import 'package:easy_read/shared/util/plain_app_bar.dart';
import 'package:easy_read/providers/guest_notifier.dart';
import 'package:easy_read/screens/auth/verification/components/resend_timer.dart';
import 'package:easy_read/screens/auth/verification/components/resend_with_confirm_buttons.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/shared/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class VerificationScreen extends ConsumerStatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  VerificationScreenState createState() => VerificationScreenState();
}

class VerificationScreenState extends ConsumerState<VerificationScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.watch(guestNotifierProvider).userInputCodes =
        List<String?>.filled(6, null);
  }

  @override
  Widget build(BuildContext context) {
    final guestState = ref.watch(guestNotifierProvider);

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
                      guestState.phoneNumber!.completeNumber,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Change phone number'),
                          content: IntlPhoneField(
                            decoration:
                                decorateTextInput(hintText: "Phone Number")
                                    .copyWith(
                                        border: null,
                                        focusedBorder: null,
                                        errorBorder: null),
                            onChanged: (PhoneNumber phone) =>
                                guestState.phoneNumber = phone,
                            initialCountryCode: "NG",
                            validator: (PhoneNumber? value) => Validator()
                                .validatePhoneNumber(value?.completeNumber),
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
                                final guestNotifier =
                                    ref.watch(guestNotifierProvider.notifier);
                                dynamic result = await guestNotifier
                                    .requestVerificationCodeFromApi();

                                if (result != null &&
                                    result.contains(RegExp(r"^[0-9]{6}$"))) {
                                  guestState.verificationCode = result;
                                  guestNotifier.resetOnResend();

                                  Navigator.pop(context);
                                } else {
                                  DialogHelper.showErrorDialog(
                                      context: context, description: result);
                                }
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        ),
                      ),
                      child: const Text("Change phone number?"),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: myDefaultSize * 1.7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: generateCodeInputFields(context: context),
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
      ),
    );
  }

  List<Widget> generateCodeInputFields({required BuildContext context}) {
    return List.generate(
        6, (i) => _buildCodeInputField(context: context, index: i));
  }

  Widget _buildCodeInputField(
      {required BuildContext context, required int index}) {
    return SizedBox(
      width: 50,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black87.withOpacity(.3),
              offset: const Offset(0, .75),
              blurRadius: 5,
              spreadRadius: .3,
            ),
          ],
        ),
        child: TextField(
          onChanged: (String value) {
            //- saving entered value
            ref.watch(guestNotifierProvider).userInputCodes![index] = value;
            if (value.length == 1 && index != 5) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && index != 0) {
              FocusScope.of(context).previousFocus();
            }
          },
          maxLength: 1,
          style: Theme.of(context).textTheme.headline6?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: myDefaultSize * 1.7,
                color: Colors.black,
              ),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding:
                EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
            counterText: "",
          ),
        ),
      ),
    );
  }
}
