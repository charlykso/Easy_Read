import 'package:easy_read/models/book.dart';
import 'package:easy_read/screens/home/components/book_tile.dart';
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
        const ReadingNowRoundedBottom(),
        const SizedBox(height: myDefaultSize),
        SizedBox(
          height: size.height * .35,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(
              left: myDefaultSize,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: myDefaultSize * 1.5,
                    bottom: myDefaultSize * 1.3,
                  ),
                  child: Text(
                    "Recently opened",
                    style: textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: books.length,
                    itemBuilder: (context, index) => BookTile(
                      book: books[index],
                      padding: const EdgeInsets.only(
                        left: myDefaultSize * .4,
                        bottom: myDefaultSize * .8,
                      ),
                      height: size.height * .15,
                      width: size.width * .2,
                      titleStyle: textTheme.headline6
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ReadingNowRoundedBottom extends StatelessWidget {
  const ReadingNowRoundedBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Container(
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
    );
  }
}
