import 'package:flutter/material.dart';
import 'package:shared_projects/app/data/dummyUsers.dart';
import 'package:shared_projects/app/resources/userTile.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/resources/drawer.dart';
import 'package:shared_projects/app/resources/circleAvatar.dart';

class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final users = DummyUsers;

    return Layout.render(
      tittlePage: 'Chat',
      drawerComponent: DrawerPage(),
      content: ListView.builder(
        itemCount: users.length,
        itemBuilder: (ctx, i) => UserTile(users.values.elementAt(i)),
      ),
    );
  }
}
