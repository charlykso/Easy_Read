import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/shared/util/my_divider.dart';
import 'package:flutter/material.dart';

class MyWingedDivider extends StatelessWidget {
  /// A divider with text in the middle
  const MyWingedDivider({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: myDefaultSize * 2),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            const MyDivider(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: myDefaultSize * 0.5),
              child: Text(
                text,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const MyDivider(),
          ],
        ),
      ),
    );
  }
}
