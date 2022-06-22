import 'package:easy_read/model/book.dart';
import 'package:easy_read/screens/home/components/home_search_filter_form.dart';
import 'package:easy_read/screens/home/components/search_result.dart';
import 'package:easy_read/screens/home/components/search_suggestion.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/shared/util/no_search_result.dart';
import 'package:flutter/material.dart';

class HomeSearchDelegate extends SearchDelegate {
  HomeSearchDelegate() : super(searchFieldLabel: 'Search by title');

  List<Book> searchResults = books;

  Future<dynamic> _showSearchFilter(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => const HomeSearchFilterForm(),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () => _showSearchFilter(context),
          icon: Icon(
            Icons.tune_rounded,
            color: Theme.of(context).primaryColor,
            size: myDefaultSize * 2,
          ),
        ),
        IconButton(
          onPressed: () => query.isEmpty ? close(context, null) : query = '',
          icon: Icon(
            Icons.close_rounded,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ];

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
            : ListView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: results.length,
                itemBuilder: (context, index) => SearchResult(
                  result: results[index],
                ),
              );
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
