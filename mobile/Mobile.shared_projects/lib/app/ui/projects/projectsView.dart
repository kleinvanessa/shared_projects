import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/resources/drawer.dart';
import 'package:shared_projects/app/ui/projects/projectDetails.dart';

class ProjectsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout.render(
      tittlePage: 'Projetos',
      drawerComponent: DrawerPage(),
      content: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          TextFormField(
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
          SizedBox(
            height: 50,
          ),
          _projectsItems('Projeto 1', 'Descrição projeto 1', context),
          SizedBox(
            height: 10,
          ),
          _projectsItems('Projeto 2', 'Descrição projeto 2', context),
          SizedBox(
            height: 10,
          ),
          _projectsItems('Projeto 3', 'Descrição projeto 3', context),
          SizedBox(
            height: 10,
          ),
          _projectsItems('Projeto 4', 'Descrição projeto 4', context),
          SizedBox(
            height: 10,
          ),
          _projectsItems('Projeto 5', 'Descrição projeto 5', context),
          SizedBox(
            height: 10,
          ),
          _projectsItems('Projeto 6', 'Descrição projeto 6', context),
          SizedBox(
            height: 10,
          ),
          _projectsItems('Projeto 7', 'Descrição projeto 7', context),
        ],
      )),
    );
  }

  Widget _projectsItems(projectName, projectDescription, context) {
    return Row(
      children: <Widget>[
        Material(
          color: Color(0xFF583D72),
          child: Ink.image(
              image: AssetImage('assets/img/docProj.png'),
              //fit: BoxFit.cover,
              width: 90.0,
              height: 90.0,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ProjectsDetails(
                                imageProject: 'assets/img/docProj.png',
                                nameProject: projectName,
                              )));
                },
              )),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Container(
              // alignment: Alignment.topLeft,
              // padding: const EdgeInsets.all(20),

              child: Text(
                projectName,
                style: TextStyle(fontSize: 16, color: Color(0xFF583D72)),
              ),
            ),
            Text(
              projectDescription,
              style: TextStyle(fontSize: 12, color: Color(0xFF000000)),
            ),
          ],
        ),
      ],
    );
  }
}
