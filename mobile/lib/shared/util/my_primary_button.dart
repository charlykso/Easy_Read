import 'package:flutter/material.dart';
import 'package:easy_read/shared/helpers.dart';

class MyPrimaryButton extends StatelessWidget {
  /// The primary button for this app
  const MyPrimaryButton({
    Key? key,
    required this.text,
    this.press,
    this.height = myDefaultSize * 3,
    this.width,
    this.bgColor,
  }) : super(key: key);

  final String text;
  final Function()? press;
  final double? height;
  final double? width;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: height,
      width: width ?? myDefaultSize * 18,
      child: TextButton(
        onPressed: press,
        style: TextButton.styleFrom(
          backgroundColor: bgColor ?? myPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(myDefaultSize * .8),
            side: const BorderSide(color: myPrimaryColor),
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
