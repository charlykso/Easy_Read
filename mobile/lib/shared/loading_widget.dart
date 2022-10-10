import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    this.backgroundColor,
    this.strokeWidth,
  }) : super(key: key);

  final Color? backgroundColor;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: backgroundColor ?? mySecondaryColor,
        strokeWidth: strokeWidth ?? 6.0,
      ),
    );
  }
}
