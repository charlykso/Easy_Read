import 'package:flutter/material.dart';
import 'package:easy_read/shared/helpers.dart';

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: isMobile ? 250 : 240,
          width: isMobile ? 170 : 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(myDefaultSize),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: myDefaultSize),
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
                      style: currentTheme.textTheme.titleMedium
                          ?.copyWith(color: Colors.black.withOpacity(.6)),
                    ),
                    TextSpan(
                      text: '\u20A6${price.toStringAsFixed(2)}',
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
        // ElevatedButton.icon(
        //   onPressed: () {},
        //   icon: const Icon(Icons.monetization_on),
        //   label: Text(price.toStringAsFixed(2)),
        // ),
      ],
    );
  }
}
