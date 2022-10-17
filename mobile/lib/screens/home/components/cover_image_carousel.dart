import 'package:easy_read/models/book.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CoverImageCarousel extends StatelessWidget {
  const CoverImageCarousel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: myDefaultSize * 11,
      child: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => context.goNamed('details',
              params: {'bookId': books[index].id.toString()}),
          child: Container(
            height: myDefaultSize * 1.2,
            width: myDefaultSize * 7.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(myDefaultSize * .8),
              image: DecorationImage(
                image: AssetImage(books[index].coverImage),
                fit: BoxFit.fill,
              ),
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: myDefaultSize * .4,
            ),
          ),
        ),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
