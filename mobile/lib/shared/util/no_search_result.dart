import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';

class NoSearchResult extends StatelessWidget {
  const NoSearchResult({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: myDefaultSize * 1.2),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/no_search_result.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
