import 'package:easy_read/models/book.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({
    Key? key,
    required this.result,
  }) : super(key: key);

  final Book result;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      height: size.height * 0.3,
      child: Padding(
        padding: const EdgeInsets.all(myDefaultSize),
        child: Row(
          children: [
            Container(
              width: size.width * 0.35,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(myDefaultSize),
                image: DecorationImage(
                  image: AssetImage(result.coverImage),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: myDefaultSize,
                  top: myDefaultSize,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.title,
                      style: theme.textTheme.headline5?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      result.author,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: myDefaultSize * 0.4),
                    Flexible(
                      child: Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                        style: theme.textTheme.subtitle2?.copyWith(
                          color: myTextColor.withOpacity(.4),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
