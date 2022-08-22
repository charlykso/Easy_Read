import 'package:easy_read/shared/helpers.dart' show myDefaultSize;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreenBackground extends StatelessWidget {
  const AuthScreenBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          bottom: 46,
          height: size.height * .65,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: myDefaultSize),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: myDefaultSize * 4),
                child: child,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          height: size.height * .3,
          child: SvgPicture.asset(
            "assets/images/new_reg1.svg",
          ),
        ),
      ],
    );
  }
}
