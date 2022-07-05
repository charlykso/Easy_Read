import 'package:easy_read/screens/auth/sign_in/sign_in_screen.dart';
import 'package:easy_read/screens/home/components/home_search_delegate.dart';
import 'package:easy_read/services/google_auth.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          IconButton(
            onPressed: () async {
              final dynamic user = await GoogleAuth.signOut();

              if (user == null) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: myAnimationDuration,
                    backgroundColor: Colors.red[700],
                    content: const Text('Sign out attempt failed!'),
                  ),
                );
              }
            },
            icon: const Icon(
              Icons.exit_to_app_rounded,
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
