import 'package:easy_read/providers/user_state.dart';
import 'package:easy_read/screens/home/components/home_search_delegate.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/shared/my_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

AppBar myDefaultAppBar(BuildContext context, {PreferredSizeWidget? bottom}) {
  return AppBar(
    surfaceTintColor: Colors.white,
    backgroundColor: Colors.white,
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications_rounded),
      ),
      PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? _) {
              return TextButton.icon(
                onPressed: () => ref.read(userProvider.notifier).logout(),
                icon: const Icon(Icons.logout_outlined),
                label: const Text('Logout'),
              );
            }),
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
    bottom: bottom ??
        PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: InkWell(
            onTap: () => showMySearch(
              context: context,
              delegate: HomeSearchDelegate(),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: myDefaultSize),
              height: 43,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(myDefaultSize * 1.5),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 4),
                    blurRadius: 4.0,
                    spreadRadius: 1.5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: myTextColor.withOpacity(.6),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Book Title',
                    style: TextStyle(
                      color: myTextColor.withOpacity(.6),
                      fontSize: myDefaultSize * 1.1,
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
  );
}
