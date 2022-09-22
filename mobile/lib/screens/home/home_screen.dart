import 'package:easy_read/shared/drawer/navigation_drawer.dart';
import 'package:easy_read/shared/my_default_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myDefaultAppBar(context),
      drawer: const NavigationDrawer(),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: const Center(
          child: Text('sknk'),
        ),
      ),
    );
  }
}
