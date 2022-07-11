import 'package:easy_read/models/book.dart';
import 'package:easy_read/screens/detail/components/author_with_publication_year.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/shared/util/my_primary_button.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: size.height * 0.4,
            width: size.width * 0.6,
            padding: const EdgeInsets.symmetric(vertical: myDefaultSize * 1.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(myDefaultSize),
              image: DecorationImage(
                image: AssetImage(book.coverImage),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: myDefaultSize * 1.5),
          Text(
            book.title,
            style: theme.textTheme.headline1?.copyWith(
              color: Colors.black,
              fontSize: myDefaultSize * 3.6,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: myDefaultSize * 0.8),
          AuthorWithPublicationYear(
            author: book.author,
            yearOfPublication: book.publicationYear.toString(),
          ),
          const SizedBox(height: myDefaultSize),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: myDefaultSize * 3),
            child: MyPrimaryButton(
              press: () {
                //TODO: Navigate to checkout screen
              },
              text: 'Purchase',
              width: double.infinity,
            ),
          ),
          const SizedBox(height: myDefaultSize * 1.6),
          const Divider(
            height: 2.0,
            thickness: 2.0,
            color: mySecondaryColor,
          ),
          const SizedBox(height: myDefaultSize * 1.6),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: myDefaultSize * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Book Description',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: myDefaultSize),
                      Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                        style: theme.textTheme.subtitle2?.copyWith(
                          color: myTextColor.withOpacity(.4),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
