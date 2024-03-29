import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialMediaIcon extends StatelessWidget {
  const SocialMediaIcon({
    Key? key,
    this.tap,
    required this.imagePath,
    this.color,
  }) : super(key: key);

  final Function()? tap;
  final String imagePath;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(myDefaultSize),
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
          height: myDefaultSize * 2.5,
          width: myDefaultSize * 2.5,
        ),
      ),
    );
  }
}
