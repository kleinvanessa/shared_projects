import 'package:flutter/material.dart';
import 'package:shared_projects/app/model/curriculum.dart';
import 'package:shared_projects/app/model/payment.dart';
import 'package:shared_projects/app/model/user.dart';
import 'package:shared_projects/app/resources/circleAvatar.dart';
import 'package:shared_projects/app/ui/projects/myEnrolled.dart';
import 'package:shared_projects/app/ui/projects/myProjectsPage.dart';
import 'package:shared_projects/app/ui/favorites/favorite.dart';
import 'package:shared_projects/app/ui/projects/mySubscriptions.dart';
import 'package:shared_projects/app/ui/profile/profile.dart';
import 'package:shared_projects/app/ui/authentication/login.dart';
import 'package:shared_projects/app/utils/nav.dart';

class DrawerPage extends StatelessWidget {
  final userId;
  const DrawerPage({
    this.userId,
  });
  @override
  Widget build(BuildContext context) {
    Future<User> future = User.get();
    return SafeArea(
      child: Drawer(
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.zero,
          children: <Widget>[
            FutureBuilder<User>(
                future: future,
                builder: (context, snapshot) {
                  User user = snapshot.data;
                  print("userId: $userId");
                  return user != null ? _drawerHeader(user) : Container();
                }),
            _listTileMethod(
              context,
              'Meus Projetos',
              MyProjectsPage(),
              typeLeading: Icons.my_library_books_outlined,
            ),
            _listTileMethod(
              context,
              'Minhas Inscrições',
              MySubscriptionsPage(),
              typeLeading: Icons.edit,
            ),
            /* _listTileMethod(
              context,
              'Meus inscritos',
              MyEnrolledPage(), //TODO
              typeLeading: Icons.person,
            ),*/
            _listTileMethod(
              context,
              'Favoritos',
              FavoritesPage(userId: userId),
              typeLeading: Icons.favorite,
            ),
            /*_listTileMethod(
              context,
              'Configurações',
              SettingsPage(),
              typeLeading: Icons.settings,
            ),*/
            _listTileMethod(
              context,
              'Sair',
              LoginPage(),
              replace: true,
              clear: true,
              typeLeading: Icons.logout,
            ),
          ],
        ),
      ),
    );
  }

  _drawerHeader(user) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Color(0xFF583D72),
      ),
      child: Column(
        children: <Widget>[
          CircularAvatar(
            isButton: true,
            image: user.image,
            routeAvatar: ProfilePage(),
          ),
          Text(
            "${user.name}" + " " + "${user.lastName}",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(
            '${user.email}',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFFFFFFFF).withOpacity(.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listTileMethod(dynamic context, String textTitle, navRoute,
      {clear = false, replace = false, typeLeading}) {
    return ListTile(
      leading: typeLeading != null
          ? Icon(typeLeading, color: Color(0xFF583D72))
          : null,
      trailing: Icon(Icons.arrow_right, color: Color(0xFF583D72)),
      title: Text('$textTitle', style: TextStyle(color: Color(0xFF583D72))),
      onTap: () {
        _clickOnTap(context, navRoute, replace: replace, clear: clear);
      },
    );
  }

  _clickOnTap(context, navRoute, {clear = false, replace = false}) {
    if (clear) {
      _clickLogOut(context, navRoute, true);
    } else {
      push(context, navRoute, replace: replace);
    }
  }

  void _clickLogOut(ctx, navRoute, replace) {
    _AlertLogOut("Aviso", "Tem certeza que deseja fazer logout?", ctx, navRoute,
        replace);
  }

  void _AlertLogOut(String title, String msg, context, navRoute, replace) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text(title),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                    child: Text("Sim"),
                    onPressed: () {
                      _clearAll(context, navRoute, true);
                    }),
                FlatButton(
                  child: Text("Não"),
                  onPressed: () {
                    Navigator.pop(context);
                    //print("OK!!!!!!!!");
                  },
                )
              ],
            ),
          );
        });
  }

  _clearAll(context, navRoute, replace) {
    Curriculum.clear();
    Payment.clear();
    User.clear();
    push(context, navRoute, replace: true);
  }
}
