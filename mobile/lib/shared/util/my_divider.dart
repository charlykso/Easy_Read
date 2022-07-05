import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  /// My custom divider
  const MyDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Divider(
        height: 2.5,
        color: myPrimaryColor.withOpacity(.5),
      ),
    );
  }
}
