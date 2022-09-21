import 'package:easy_read/shared/drawer/components/header.dart';
import 'package:easy_read/shared/drawer/components/menu_items.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Header(),
            MenuItems(),
          ],
        ),
      ),
    );
  }
}
