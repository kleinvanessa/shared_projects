import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/layout.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout.render(
      tittlePage: 'Favoritos',
      content: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/img/favorite.png',
              width: 200,
              height: 200,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Nenhum favorito adicionado',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF583D72),
            ),
          ),
        ],
      )),
    );
  }
}
