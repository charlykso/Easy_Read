import 'dart:io' show Platform;

import 'package:easy_read/models/book.dart';
import 'package:easy_read/screens/detail/components/body.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/shared/util/plain_app_bar.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.book}) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: plainAppBar(
        context: context,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: myDefaultSize * 0.3),
            child: IconButton(
              onPressed: () => {},
              icon: Icon(
                Platform.isIOS ? Icons.ios_share_rounded : Icons.share_rounded,
                color: myPrimaryColor,
              ),
            ),
          ),
        ],
      ),
      body: Body(
        book: book,
      ),
    );
  }
}
