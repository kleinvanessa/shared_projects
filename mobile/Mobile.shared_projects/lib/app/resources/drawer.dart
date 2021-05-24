import 'package:flutter/material.dart';
import 'package:shared_projects/app/resources/circleAvatar.dart';
import 'package:shared_projects/app/ui/projects/myProjectsPage.dart';
import 'package:shared_projects/app/ui/favorites/favorite.dart';
import 'package:shared_projects/app/ui/settings/settings.dart';
import 'package:shared_projects/app/ui/profile/profile.dart';
import 'package:shared_projects/app/ui/authentication/login.dart';

class DrawerPage extends StatelessWidget {
  final userName = 'Vanessa Klein';
  final tagUser = '@vanessalklein';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF583D72),
              ),
              child: Column(
                children: <Widget>[
                  CircularAvatar(
                    isButton: true,
                    image: 'assets/img/profile.jpg',
                    routeAvatar: ProfilePage(),
                  ),
                  Text(
                    '$userName',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Text(
                    '$tagUser',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFFFFFFF).withOpacity(.5),
                    ),
                  ),
                ],
              ),
            ),
            _listTileMethod(context, 'Meus Projetos', MyProjectsPage(),
                Icons.arrow_forward_ios_rounded),
            _listTileMethod(context, 'Favoritos', FavoritesPage(),
                Icons.arrow_forward_ios_rounded),
            SizedBox(height: 250),
            _listTileMethod(
                context, 'Configurações', SettingsPage(), Icons.settings),
            _listTileMethod(context, 'Sair', LoginPage(), Icons.logout),
          ],
        ),
      ),
    );
  }

  Widget _listTileMethod(
      dynamic context, String textTitle, navRoute, typeLeading) {
    return ListTile(
      trailing: Icon(typeLeading, color: Color(0xFF583D72)),
      title: Text('$textTitle', style: TextStyle(color: Color(0xFF583D72))),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navRoute),
        );
      },
    );
  }
}
