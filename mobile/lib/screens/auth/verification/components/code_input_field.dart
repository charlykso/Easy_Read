import 'package:easy_read/providers/guest_notifier.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CodeInputField extends StatelessWidget {
  const CodeInputField({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: myDefaultSize * 1.18),
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
        child: Consumer(
          builder: (_, ref, __) {
            final guestNotifier = ref.watch(guestNotifierProvider.notifier);

            return TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  guestNotifier.setInputCode(userInput: value, index: index);
                  FocusScope.of(context).nextFocus();
                }
              },
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.bold),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            );
          },
        ),
      ),
    );
  }
}
