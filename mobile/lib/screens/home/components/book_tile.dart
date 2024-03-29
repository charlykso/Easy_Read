import 'package:easy_read/models/book.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

class BookTile extends StatelessWidget {
  const BookTile({
    Key? key,
    required this.book,
    this.padding,
    this.height,
    this.width,
    this.titleStyle,
  }) : super(key: key);

  final Book book;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () =>
          context.goNamed('details', params: {'bookId': book.id.toString()}),
      child: SizedBox(
        height: height ?? size.height * 0.2,
        child: Padding(
          padding: padding ??
              const EdgeInsets.only(
                top: myDefaultSize * 1.2,
                left: myDefaultSize,
              ),
          child: Row(
            children: [
              Container(
                width: width ?? size.width * 0.25,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(myDefaultSize * .5),
                  image: DecorationImage(
                    image: AssetImage(book.coverImage),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: myDefaultSize * .9,
                    top: myDefaultSize * .4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: titleStyle ??
                            theme.textTheme.headline5?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        book.author,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: myDefaultSize * 1.1,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          RatingBar(
                            minRating: 1,
                            initialRating: 4,
                            maxRating: 5,
                            ratingWidget: RatingWidget(
                              full: const Icon(
                                Icons.star,
                                color: mySecondaryColor,
                              ),
                              half: const Icon(
                                Icons.star_half,
                                color: mySecondaryColor,
                              ),
                              empty: const Icon(
                                Icons.star,
                                color: Colors.grey,
                              ),
                            ),
                            itemSize: 24,
                            onRatingUpdate: (rating) {},
                          ),
                          const SizedBox(width: myDefaultSize * .4),
                          const Text("58 Ratings"),
                        ],
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
