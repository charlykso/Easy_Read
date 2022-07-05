import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';

class AuthorWithPublicationYear extends StatelessWidget {
  const AuthorWithPublicationYear({
    Key? key,
    required this.author,
    required this.yearOfPublication,
  }) : super(key: key);

  final String author;
  final String yearOfPublication;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'by ',
                style: theme.textTheme.bodyText1,
              ),
              TextSpan(
                text: author,
                style: theme.textTheme.bodyText1?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
              TextSpan(
                text: ' | ',
                style: theme.textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: myDefaultSize * 1.3,
                ),
              ),
              TextSpan(
                text: yearOfPublication,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
