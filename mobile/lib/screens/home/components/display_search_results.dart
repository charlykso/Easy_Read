import 'package:easy_read/models/book.dart';
import 'package:easy_read/screens/home/components/book_card.dart';
import 'package:easy_read/screens/home/components/book_tile.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';

class DisplaySearchResults extends StatefulWidget {
  const DisplaySearchResults({
    Key? key,
    required this.results,
  }) : super(key: key);

  final List<Book> results;

  @override
  State<DisplaySearchResults> createState() => _DisplaySearchResultsState();
}

class _DisplaySearchResultsState extends State<DisplaySearchResults> {
  bool isListView = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width < 700;

    return Column(
      children: [
        const SizedBox(height: myDefaultSize * 1.5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: myDefaultSize),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Search Results",
                style: TextStyle(
                  fontSize: myDefaultSize * 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () => setState(() => isListView = true),
                    child: Ink(
                      padding: const EdgeInsets.only(right: 2.5),
                      child: Icon(
                        Icons.view_list_rounded,
                        color: isListView ? mySecondaryColor : myTextColor,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => setState(() => isListView = false),
                    child: Ink(
                      padding: const EdgeInsets.only(left: 2.5),
                      child: Icon(
                        Icons.grid_view_rounded,
                        color: isListView == false
                            ? mySecondaryColor
                            : myTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Flexible(
          child: AnimatedCrossFade(
            firstChild: ListView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: widget.results.length,
              itemBuilder: (context, index) => BookTile(
                book: widget.results[index],
              ),
            ),
            secondChild: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: myDefaultSize,
                childAspectRatio: isMobile ? 0.52 : 0.57,
              ),
              itemCount: widget.results.length,
              itemBuilder: (context, index) => BookCard(
                book: widget.results[index],
              ),
            ),
            duration: myAnimationDuration,
            crossFadeState: isListView
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
        ),
      ],
    );
  }
}
