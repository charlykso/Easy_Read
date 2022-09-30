import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  /// My custom [ElevatedButton]
  const CustomButton({
    Key? key,
    required this.text,
    this.press,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  final String text;
  final Function()? press;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.4,
      height: myDefaultSize * 3.5,
      child: ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(myDefaultSize * 1.4),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: myDefaultSize * 1.25,
            fontWeight: FontWeight.w500,
            color: textColor ?? textColor,
          ),
        ),
      ),
    );
  }
}
