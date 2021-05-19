import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/layout.dart';

class RedefinePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout.render(
        tittlePage: 'Nova senha',
        content: Column(
          children: <Widget>[Text('Senha')],
        ));
  }
}
