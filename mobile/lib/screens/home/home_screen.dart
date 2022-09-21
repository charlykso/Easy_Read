import 'package:easy_read/screens/auth/sign_in/sign_in_screen.dart';
import 'package:easy_read/services/auth_service.dart';
import 'package:easy_read/shared/drawer/navigation_drawer.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final AuthService authService = AuthService();

  _signUserOut(BuildContext context) async {
    final dynamic result = await authService.signOut();

    // TODO: Implement this auto with riverpod
    if (result == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: myAnimationDuration * 3,
          backgroundColor: Colors.red[700],
          content: const Text('Sign out attempt failed!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_rounded),
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: TextButton.icon(
                  onPressed: () => _signUserOut(context),
                  icon: const Icon(Icons.logout_outlined),
                  label: const Text('Logout'),
                ),
              ),
            ],
            position: PopupMenuPosition.under,
            child: const CircleAvatar(
              radius: myDefaultSize * 1.2,
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
          ),
          const SizedBox(width: myDefaultSize),
        ],
      ),
      drawer: const NavigationDrawer(),
      body: Container(),
    );
  }
}
