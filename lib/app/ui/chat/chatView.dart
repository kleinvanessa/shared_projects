import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/resources/drawer.dart';
import 'package:shared_projects/app/resources/circleAvatar.dart';

class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout.render(
        tittlePage: 'Chat',
        drawerComponent: DrawerPage(),
        content: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Text(
                'Conversas',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF583D72),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: CircularAvatar(
                      isButton: false, image: 'assets/img/img1.png'),
                ),
                SizedBox(width: 10),
                Text('Contato 1'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: CircularAvatar(
                      isButton: false, image: 'assets/img/img2.png'),
                ),
                SizedBox(width: 10),
                Text('Contato 2'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: CircularAvatar(
                      isButton: false, image: 'assets/img/img3.png'),
                ),
                SizedBox(width: 10),
                Text('Contato 3'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: CircularAvatar(
                      isButton: false, image: 'assets/img/img4.png'),
                ),
                SizedBox(width: 10),
                Text('Contato 4'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: CircularAvatar(
                      isButton: false, image: 'assets/img/img5.png'),
                ),
                SizedBox(width: 10),
                Text('Contato 5'),
              ],
            ),
          ],
        ));
  }
}
