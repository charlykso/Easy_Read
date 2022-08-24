import 'package:easy_read/shared/helpers.dart' show myDefaultSize;
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
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

    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) => Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 46,
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: myDefaultSize),
              child: AnimatedContainer(
                height: size.height * .65,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                duration: const Duration(milliseconds: 500),
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
            child: AnimatedOpacity(
              // If keyboard is visible, animate to 0.0 (invisible).
              // If keyboard is not visible, animate to 1.0 (fully visible).
              opacity: isKeyboardVisible ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 500),
              child: SvgPicture.asset(
                "assets/images/new_reg1.svg",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
