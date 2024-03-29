import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppBar plainAppBar({
  required BuildContext context,
  Color? backgroundColor = Colors.transparent,
  Color? surfaceTintColor = Colors.white,
  List<Widget>? actions,
  Widget? title,
  bool hasLeadingBackButton = true,
}) {
  return AppBar(
    automaticallyImplyLeading: hasLeadingBackButton,
    leading: hasLeadingBackButton
        ? IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: myPrimaryColor,
            ),
          )
        : null,
    backgroundColor: backgroundColor,
    surfaceTintColor: surfaceTintColor,
    actions: actions,
  );
}
