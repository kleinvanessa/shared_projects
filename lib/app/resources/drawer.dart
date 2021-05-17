import 'package:flutter/material.dart';
import 'package:shared_projects/app/resources/circleAvatar.dart';
import 'package:shared_projects/app/ui/projects/myProjectsPage.dart';
import 'package:shared_projects/app/ui/favorites/favorite.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF583D72),
              ),
              child: Column(
                children: <Widget>[
                  CircularAvatar(),
                  Text(
                    'Vanessa Klein',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Text(
                    '@vanessalklein',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFFFFFFF).withOpacity(.5),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Meus Projetos',
                  style: TextStyle(color: Color(0xFF583D72))),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyProjectsPage()),
                );
              },
            ),
            ListTile(
              title:
                  Text('Favoritos', style: TextStyle(color: Color(0xFF583D72))),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
