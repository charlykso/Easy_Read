import 'package:flutter/material.dart';
import 'package:easy_read/model/book.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/screens/home/components/book_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width < 700;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: myDefaultSize * .7),
      child: GridView.builder(
        itemCount: books.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: myDefaultSize,
          childAspectRatio: isMobile ? 0.52 : 0.57,
        ),
        itemBuilder: (context, index) => BookCard(
          image: books[index].coverImage,
          title: books[index].title,
          author: books[index].author,
          price: books[index].price,
        ),
      ),
    );
  }
}
