import 'package:easy_read/models/book.dart';
import 'package:easy_read/screens/detail/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_read/shared/helpers.dart';

class BookCard extends StatelessWidget {
  /// displays a book
  const BookCard({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width < 700;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(book: book),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: myDefaultSize),
        child: Column(
          children: [
            Container(
              height: isMobile ? size.height * 0.27 : size.height * .6,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(myDefaultSize * .5),
                image: DecorationImage(
                  image: AssetImage(book.coverImage),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: myDefaultSize * .4),
            Text(
              book.title,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
