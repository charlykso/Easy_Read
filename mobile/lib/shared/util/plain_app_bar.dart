import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';

AppBar plainAppBar({
  required BuildContext context,
  Color? backgroundColor = Colors.transparent,
  Color? surfaceTintColor = Colors.white,
  List<Widget>? actions,
  Widget? title,
}) {
  return AppBar(
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(
        Icons.arrow_back_ios_new,
        color: myPrimaryColor,
      ),
    ),
    backgroundColor: backgroundColor,
    surfaceTintColor: surfaceTintColor,
    actions: actions,
  );
}
