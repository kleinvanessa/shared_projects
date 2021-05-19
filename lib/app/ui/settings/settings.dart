import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/layout.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout.render(
        tittlePage: 'Configurações',
        content: Column(
          children: <Widget>[Text('Configurações')],
        ));
  }
}
