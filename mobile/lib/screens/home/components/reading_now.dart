import 'package:easy_read/screens/home/components/cover_image_carousel.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';

class ReadingNow extends StatelessWidget {
  const ReadingNow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          height: size.height * .35,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(myDefaultSize * 3.5),
              bottomRight: Radius.circular(myDefaultSize * 3.5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 7),
                blurRadius: 5.0,
                spreadRadius: 1.2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: myDefaultSize * 2,
              left: myDefaultSize,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: myDefaultSize * 2.2,
                    bottom: myDefaultSize * 1.5,
                  ),
                  child: Text(
                    "Reading Now",
                    style: textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const CoverImageCarousel(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
