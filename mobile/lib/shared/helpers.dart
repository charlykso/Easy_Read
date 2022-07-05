import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';

const myDefaultSize = 14.0;
const myAnimationDuration = Duration(milliseconds: 200);
const myTextColor = Color(0xbf212121);
const myPrimaryColor = Color(0xFF4CAF50);
const mySecondaryColor = Color(0xFF388E3C);
const myLightGreyColor = Color(0x66efefef);

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

Color? getColor(Set<MaterialState> states) {
  if (states.hasError) {
    return Colors.red;
  } else if (states.isSelected) {
    return myPrimaryColor;
  }
  return Colors.grey.withOpacity(.4);
}
