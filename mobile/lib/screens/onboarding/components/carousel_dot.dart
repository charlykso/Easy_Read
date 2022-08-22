import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';

class CarouselDot extends StatelessWidget {
  const CarouselDot({
    Key? key,
    required this.currentPage,
    required this.index,
  }) : super(key: key);

  final int currentPage, index;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: myAnimationDuration,
      height: myDefaultSize * .75,
      width: myDefaultSize * .75,
      decoration: BoxDecoration(
        color:
            currentPage == index ? myTextColor : myTextColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(myDefaultSize * 0.8),
      ),
      margin: const EdgeInsets.only(right: myDefaultSize * .5),
    );
  }
}
