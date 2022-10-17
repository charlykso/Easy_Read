import 'package:easy_read/screens/home/components/reading_now_rounded_bottom.dart';
import 'package:easy_read/screens/home/components/recently_opened.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';

class ReadingNow extends StatelessWidget {
  const ReadingNow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ReadingNowRoundedBottom(),
        SizedBox(height: myDefaultSize),
        RecentlyOpened(),
      ],
    );
  }
}
