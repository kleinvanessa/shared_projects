import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/layout.dart';

class MyProjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout.render(
        tittlePage: 'Meus Projetos',
        content: Column(
          children: <Widget>[Text('Meus Projetos')],
        ));
  }
}
