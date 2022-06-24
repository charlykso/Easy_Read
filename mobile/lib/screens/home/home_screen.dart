import 'package:easy_read/screens/home/components/home_search_delegate.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "Easy Read",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                showSearch(context: context, delegate: HomeSearchDelegate()),
            icon: const Icon(
              Icons.search_rounded,
              color: myPrimaryColor,
              size: 30.0,
            ),
          ),
          IconButton(
            onPressed: () {
              //TODO: Navigate to library
            },
            icon: const Icon(
              Icons.my_library_books_rounded,
              color: myPrimaryColor,
              size: 30.0,
            ),
          ),
        ],
      ),
      body: const Body(),
    );
  }
}
