import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/resources/drawer.dart';

class ProjectsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout.render(
        tittlePage: 'Projetos',
        drawerComponent: DrawerPage(),
        content: Column(
          children: <Widget>[Text('Projetos')],
        ));
  }
}
