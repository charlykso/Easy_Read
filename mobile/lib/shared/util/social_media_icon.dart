import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialMediaIcon extends StatelessWidget {
  const SocialMediaIcon({
    Key? key,
    this.tap,
    required this.imagePath,
    this.color,
    this.backgroundColor,
  }) : super(key: key);

  final Function()? tap;
  final String imagePath;
  final Color? color, backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        padding: const EdgeInsets.all(myDefaultSize),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(myDefaultSize),
          color: backgroundColor ?? myPrimaryColor.withOpacity(.5),
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 1.5,
              offset: const Offset(3, 2),
              color: mySecondaryColor.withOpacity(.2),
            ),
          ],
        ),
        child: SvgPicture.asset(
          imagePath,
          height: myDefaultSize * 1.3,
          width: myDefaultSize * 1.3,
          color: color ?? myTextColor,
        ),
      ),
    );
  }
}
