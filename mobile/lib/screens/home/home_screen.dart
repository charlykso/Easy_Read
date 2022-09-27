import 'package:easy_read/screens/home/components/reading_now.dart';
import 'package:easy_read/shared/drawer/navigation_drawer.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/shared/my_default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _bottomNavigationBarItems = [
    ReadingNow(),
    Center(
      child: Text(
        'Book Store',
        style: optionStyle,
      ),
    ),
    Center(
      child: Text(
        'Library',
        style: optionStyle,
      ),
    ),
    Center(
      child: Text(
        'Preferences',
        style: optionStyle,
      ),
    ),
  ];

  void _onItemTapped(value) => setState(() => _selectedIndex = value);

  @override
  Widget build(BuildContext context) {
    double? svgIconSize = myDefaultSize * 1.5;
    const EdgeInsetsGeometry bottomNavIconPadding =
        EdgeInsets.only(bottom: myDefaultSize * .3);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: myPrimaryColor,
      appBar: myDefaultAppBar(context),
      drawer: const NavigationDrawer(),
      body: Container(
        height: size.height * .85,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(myDefaultSize * 3.5),
            bottomRight: Radius.circular(myDefaultSize * 3.5),
          ),
        ),
        child: _bottomNavigationBarItems[_selectedIndex],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: myPrimaryColor,
        ),
        child: SizedBox(
          height: myDefaultSize * 6,
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Padding(
                  padding: bottomNavIconPadding,
                  child: SvgPicture.asset(
                    "assets/icons/book.svg",
                    height: svgIconSize,
                    width: svgIconSize,
                    color: Colors.white,
                  ),
                ),
                label: 'Reading Now',
              ),
              const BottomNavigationBarItem(
                icon: Padding(
                  padding: bottomNavIconPadding,
                  child: Icon(Icons.business_center),
                ),
                label: 'Book Store',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: bottomNavIconPadding,
                  child: SvgPicture.asset(
                    "assets/icons/books.svg",
                    height: svgIconSize,
                    width: svgIconSize,
                    color: Colors.white,
                  ),
                ),
                label: 'Library',
              ),
              const BottomNavigationBarItem(
                icon: Padding(
                  padding: bottomNavIconPadding,
                  child: Icon(Icons.settings),
                ),
                label: 'Personalize',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            showUnselectedLabels: true,
            iconSize: 28.0,
          ),
        ),
      ),
    );
  }
}
