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
          children: <Widget>[
            Expanded(
              flex: 2,
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search, color: Color(0xFF583D72)),
                  hintText: 'Pesquisar projetos',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF000000).withOpacity(.3),
                    fontStyle: FontStyle.italic,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF583D72).withOpacity(.4),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF583D72)),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
