import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

const myDefaultSize = 16.0;
const myAnimationDuration = Duration(milliseconds: 200);
const myTextColor = Color(0xFF000000);
const myPrimaryColor = Color(0xFF336591);
const mySecondaryColor = Color(0xFFEE8803);
const myLightGreyColor = Color(0x66efefef);
const myErrorColor = Color(0xFFFFB300);

/// Fancy extension to simplfy [MaterialState] calls
extension MaterialStateSet on Set<MaterialState> {
  bool get hasError => contains(MaterialState.error);
  bool get isSelected => contains(MaterialState.selected);
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

//* Debug mode
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
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(myDefaultSize * .8),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: myDefaultSize,
      vertical: myDefaultSize,
    ),
    hintText: hintText,
    hintStyle: const TextStyle(fontSize: myDefaultSize * 1.35),
  );
}
