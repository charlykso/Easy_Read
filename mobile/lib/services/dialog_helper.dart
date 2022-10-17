import 'package:flutter/material.dart';

class DialogHelper {
  static Future<void> showErrorDialog({
    required BuildContext context,
    String? description,
    String? title,
  }) async {
    final ThemeData theme = Theme.of(context);

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title ?? 'Operation failed',
            style:
                theme.textTheme.titleLarge?.copyWith(color: theme.primaryColor),
          ),
          content: Text(
            description ?? 'Oops, something went wrong!',
            style: theme.textTheme.bodyText1,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
