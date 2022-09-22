import 'package:easy_read/models/book.dart';
import 'package:easy_read/screens/home/components/display_search_results.dart';
import 'package:easy_read/screens/home/components/search_suggestion.dart';
import 'package:easy_read/shared/my_search.dart';
import 'package:easy_read/shared/util/no_search_result.dart';
import 'package:flutter/material.dart';

class HomeSearchDelegate extends MySearchDelegate {
  HomeSearchDelegate() : super(searchFieldLabel: 'Search by title');

  List<Book> searchResults = books;

  @override
  List<Widget>? buildActions(BuildContext context) => null;

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: Icon(
          Icons.arrow_back_rounded,
          color: Theme.of(context).primaryColor,
        ),
      );

  @override
  Widget buildResults(BuildContext context) {
    List<Book> results = searchResults.where((searchResult) {
      final result = searchResult.title.toLowerCase();
      final searchTerm = query.toLowerCase();

      return result.contains(searchTerm);
    }).toList();

    return results.isEmpty
        ? const NoSearchResult()
        : query.isEmpty
            ? Container()
            : DisplaySearchResults(results: results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Book> suggestions = searchResults.where((searchResult) {
      final result = searchResult.title.toLowerCase();
      final searchTerm = query.toLowerCase();

      return result.contains(searchTerm);
    }).toList();

    return query.isEmpty
        ? Container()
        : ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: suggestions.length,
            itemBuilder: (context, index) => SearchSuggestion(
              suggestion: suggestions[index].title,
              query: query,
              onTap: () {
                query = suggestions[index].title;
                showResults(context);
              },
            ),
          );
  }
}
