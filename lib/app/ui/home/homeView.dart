import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/resources/drawer.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout.render(
        tittlePage: 'Home',
        drawerComponent: DrawerPage(),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                'SharedProjetcs',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF583D72),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Image.asset(
                'assets/img/undraw_education_f8ru.png',
                //height: 200,
                //width: 250,
              ),
            ),
            SizedBox(height: 10),
          ],
        ));
  }
}
