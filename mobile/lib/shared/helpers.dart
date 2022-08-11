import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

const myDefaultSize = 14.0;
const myAnimationDuration = Duration(milliseconds: 200);
const myTextColor = Color(0xbf212121);
const myPrimaryColor = Color(0xFF4CAF50);
const mySecondaryColor = Color(0xFF388E3C);
const myLightGreyColor = Color(0x66efefef);
final Color myErrorColor = Colors.amber[600] ?? Colors.amber;

/// Fancy extension to simplfy [MaterialState] calls
extension MaterialStateSet on Set<MaterialState> {
  bool get hasError => contains(MaterialState.error);
  bool get isSelected => contains(MaterialState.selected);
}

// TODO: Remove this method on release build
// * For Debug mode only
extension Log on Object {
  void log() => devtools.log(toString());
}

Logger logger = Logger(
  // Customize the printer
  printer: PrettyPrinter(
    methodCount: 0,
    printTime: false,
  ),
);

Color? getColor(Set<MaterialState> states) {
  if (states.hasError) {
    return Colors.red;
  } else if (states.isSelected) {
    return myPrimaryColor;
  }
  return Colors.grey.withOpacity(.4);
}

InputDecoration decorateTextInput({required String hintText}) {
  return InputDecoration(
    filled: true,
    fillColor: myLightGreyColor,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(myDefaultSize * 1.43),
      borderSide: const BorderSide(color: myPrimaryColor),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(myDefaultSize * 1.43),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(myDefaultSize * 1.43),
      borderSide: BorderSide(color: myErrorColor),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: myDefaultSize * 1.43,
      vertical: myDefaultSize * 2,
    ),
    hintText: hintText,
    hintStyle: const TextStyle(fontSize: myDefaultSize * 1.35),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(myDefaultSize * 1.43),
      borderSide: BorderSide(color: myErrorColor),
    ),
  );
}
