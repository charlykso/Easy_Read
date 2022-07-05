import 'package:flutter/material.dart';
import 'package:easy_read/shared/helpers.dart';

class MyPrimaryButton extends StatelessWidget {
  /// The primary button for this app
  const MyPrimaryButton({
    Key? key,
    required this.text,
    this.press,
    this.height = myDefaultSize * 4,
    this.width = myDefaultSize * 16,
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
          backgroundColor: bgColor ?? myPrimaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(myDefaultSize * 1.4),
            ),
            side: BorderSide(color: myPrimaryColor),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: bgColor != null ? myPrimaryColor : Colors.white,
            fontSize:
                bgColor != null ? myDefaultSize * 1.5 : myDefaultSize * 1.25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
