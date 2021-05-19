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
      content: SingleChildScrollView(
        child: Column(
          children: [
            _contactView('assets/img/img1.png', 'Contato 1'),
            _contactView('assets/img/img2.png', 'Contato 2'),
            _contactView('assets/img/img3.png', 'Contato 3'),
            _contactView('assets/img/undefined.png', 'Contato 4'),
            _contactView('assets/img/undefined.png', 'Contato 5'),
            _contactView('assets/img/img4.png', 'Contato 6'),
            _contactView('assets/img/undefined.png', 'Contato 7'),
            _contactView('assets/img/undefined.png', 'Contato 8'),
            _contactView('assets/img/undefined.png', 'Contato 9'),
            _contactView('assets/img/undefined.png', 'Contato 10'),
            _contactView('assets/img/img2.png', 'Contato 11'),
            _contactView('assets/img/img5.png', 'Contato 12'),
            _contactView('assets/img/img1.png', 'Contato 13'),
          ],
        ),
        // scrollDirection: Axis.vertical,
      ),
    );
  }

  Widget _contactView(img, contact) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            CircularAvatar(isButton: false, image: img, rad: 30),
            SizedBox(
              width: 30,
            ),
            Text('$contact')
          ],
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
