import 'package:flutter/material.dart';

class NoSearchResult extends StatelessWidget {
  const NoSearchResult({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/no_search_result.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
