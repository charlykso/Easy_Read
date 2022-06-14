import 'package:flutter/material.dart';

import '../constants.dart';

class MiPrimaryButton extends StatelessWidget {
  /// The primary button for this app
  const MiPrimaryButton({
    Key? key,
    required this.text,
    this.press,
    this.height = miDefaultSize * 4,
    this.width = miDefaultSize * 16,
    this.bgColor,
  }) : super(key: key);

  final String text;
  final Function()? press;
  final double? height;
  final double? width;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        onPressed: press,
        style: TextButton.styleFrom(
          backgroundColor: bgColor ?? miPrimaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(miDefaultSize * 1.4),
            ),
            side: BorderSide(color: miPrimaryColor),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: bgColor != null ? miPrimaryColor : Colors.white,
            fontSize:
                bgColor != null ? miDefaultSize * 1.5 : miDefaultSize * 1.25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
