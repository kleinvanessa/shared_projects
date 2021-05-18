import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/layout.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout.render(
        tittlePage: 'Favoritos',
        content: Column(
          children: <Widget>[Text('Favoritos')],
        ));
  }
}
