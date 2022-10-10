import 'package:easy_read/models/book.dart';
import 'package:easy_read/screens/home/components/book_tile.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';

class RecentlyOpened extends StatelessWidget {
  const RecentlyOpened({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
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
    );
  }
}
