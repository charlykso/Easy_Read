import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';

class SearchSuggestion extends StatelessWidget {
  const SearchSuggestion({
    Key? key,
    required this.suggestion,
    required this.query,
    this.onTap,
  }) : super(key: key);

  final String suggestion;
  final String query;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    int indexOfFirstLetterOfQueryInSuggestion =
        suggestion.toLowerCase().indexOf(
              query.toLowerCase(),
            );
    int indexOfLastLetterOfQueryInSuggestion =
        indexOfFirstLetterOfQueryInSuggestion + query.length;

    return ListTile(
      onTap: onTap,
      title: RichText(
        text: TextSpan(
          children: suggestion.toLowerCase().startsWith(query.toLowerCase())
              ? [
                  TextSpan(
                    text: suggestion.substring(0, query.length),
                    style: theme.textTheme.bodyText1?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: suggestion.substring(query.length),
                    style: theme.textTheme.bodyText1,
                  ),
                ]
              : [
                  TextSpan(
                    text: suggestion.substring(
                      0,
                      indexOfFirstLetterOfQueryInSuggestion,
                    ),
                    style: theme.textTheme.bodyText1,
                  ),
                  TextSpan(
                    text: suggestion.substring(
                      indexOfFirstLetterOfQueryInSuggestion,
                      indexOfLastLetterOfQueryInSuggestion,
                    ),
                    style: theme.textTheme.bodyText1?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: suggestion.substring(
                      indexOfLastLetterOfQueryInSuggestion,
                    ),
                    style: theme.textTheme.bodyText1,
                  ),
                ],
        ),
      ),
      leading: Container(
        padding: const EdgeInsets.all(myDefaultSize * 0.5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor.withOpacity(.2),
        ),
        child: const Icon(Icons.search_rounded),
      ),
      trailing: const Icon(Icons.north_west),
    );
  }
}
