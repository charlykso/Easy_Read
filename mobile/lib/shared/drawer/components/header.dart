import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 28, color: Colors.white);

    return Material(
      color: myPrimaryColor,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(
            top: myDefaultSize + MediaQuery.of(context).padding.top,
            bottom: myDefaultSize,
          ),
          child: Column(
            children: [
              const CircleAvatar(
                radius: myDefaultSize * 2.6,
                backgroundImage: AssetImage('assets/images/user.png'),
              ),
              const SizedBox(height: 12),
              const Text(
                'Sixtus Agbo',
                style: textStyle,
              ),
              Text(
                'sixtusagbo211@gmail.com',
                style: textStyle.copyWith(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
