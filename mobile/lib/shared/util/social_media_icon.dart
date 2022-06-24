import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialMediaIcon extends StatelessWidget {
  const SocialMediaIcon({
    Key? key,
    this.tap,
    required this.imagePath,
  }) : super(key: key);

  final Function()? tap;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(myDefaultSize * 1.5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1.1, color: Colors.black.withOpacity(.01)),
          color: myPrimaryColor.withOpacity(.3),
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
          height: myDefaultSize * 1.5,
          width: myDefaultSize * 1.5,
          color: myTextColor,
        ),
      ),
    );
  }
}
