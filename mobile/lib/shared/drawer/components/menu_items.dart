import 'package:easy_read/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text("Home"),
              onTap: () {
                // close navigation drawer before navigating
                Navigator.pop(context);

                // Navigate to new route
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              }),
          ListTile(
            leading: const Icon(Icons.shopping_cart_outlined),
            title: const Text("Cart"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: const Text("Favourites"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text("Notifications"),
            onTap: () {},
          ),
          const Divider(color: Colors.black54),
          ListTile(
            leading: const Icon(Icons.update),
            title: const Text("Updates"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
