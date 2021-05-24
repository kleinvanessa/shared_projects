import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/layout.dart';

class MyProjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout.render(
      tittlePage: 'Meus Projetos',
      content: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/img/notFind.png',
              width: 200,
              height: 200,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Você ainda não tem projetos',
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
