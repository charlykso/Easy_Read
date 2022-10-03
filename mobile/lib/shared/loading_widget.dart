import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: mySecondaryColor,
        strokeWidth: 6.0,
      ),
    );
  }
}
