import 'package:flutter/material.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:intl/intl.dart';

class BookCard extends StatelessWidget {
  /// displays a book
  const BookCard({
    Key? key,
    required this.image,
    required this.title,
    required this.author,
    required this.price,
  }) : super(key: key);

  final String image;
  final String title;
  final String author;
  final double price;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width < 700;
    ThemeData currentTheme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        //TODO: Navigate to book details screen
      },
      child: Container(
        height: size.height * .4,
        width: size.width * .4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(myDefaultSize),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 8),
              color: mySecondaryColor.withOpacity(.3),
              spreadRadius: 1.5,
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: isMobile ? size.height * 0.27 : size.height * .6,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(myDefaultSize),
                  topRight: Radius.circular(myDefaultSize),
                ),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: myDefaultSize * .6,
                top: myDefaultSize * .5,
              ),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$title\n',
                          style: currentTheme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: myDefaultSize * 1.1,
                          ),
                        ),
                        TextSpan(
                          text: '$author\n',
                          style: currentTheme.textTheme.titleMedium?.copyWith(
                            color: Colors.black.withOpacity(.6),
                            fontSize: myDefaultSize,
                          ),
                        ),
                        TextSpan(
                          text: NumberFormat.currency(
                            name: '\u20A6',
                            decimalDigits: 2,
                          ).format(price),
                          style: currentTheme.textTheme.button?.copyWith(
                            color: myPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
