import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeInputField extends StatelessWidget {
  const CodeInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

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
              blurRadius: 25,
              spreadRadius: 1,
            ),
          ],
        ),
        child: TextFormField(
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          style:
              theme.textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }
}
