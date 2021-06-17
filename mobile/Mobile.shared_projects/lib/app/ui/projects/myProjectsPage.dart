import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_projects/app/models/project.dart';
import 'package:shared_projects/app/models/user.dart';
import 'package:shared_projects/app/models/userProjects.dart';
import 'package:shared_projects/app/ui/chat/chatView.dart';
import 'package:shared_projects/app/ui/favorites/favorite.dart';
import 'package:shared_projects/app/ui/projects/myEnrolled.dart';
import 'package:shared_projects/app/ui/projects/projectDetails.dart';
import 'package:shared_projects/app/utils/alert.dart';
import 'package:shared_projects/app/utils/nav.dart';

import '../layout.dart';
import 'ProjectsAPI.dart';

class MyProjectsPage extends StatefulWidget {
  @override
  _MyProjectsPageState createState() => _MyProjectsPageState();
}

class _MyProjectsPageState extends State<MyProjectsPage> {
  // with AutomaticKeepAliveClientMixin<ProjectsListView> {
  //pra não fazer requisição no service toda hora, faz uma e salva
  // bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    Future<User> future = User.get();
    return Layout.render(
      tittlePage: 'Meus projetos',
      content: FutureBuilder<User>(
          future: future,
          builder: (context, snapshot) {
            User user = snapshot.data;
            return _pegarProj(user);
          }),
    );
  }

  _pegarProj(User user) {
    Future<List<Projects>> future = ProjectsAPI.getProjectsByUser();
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(
                "Error: in projectsView.dart snapshot.hasError is true with error - ${snapshot.hasError}");
            return Center(
              child: Alert(
                context,
                "Não foi possível carregar os projetos",
                "Aviso",
              ),
            );
          }
          if (!snapshot.hasData) {
            //verifica s tem dados
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFF583D72),
                ),
              ),
            );
          }
          List<Projects> projects = snapshot.data;
          return _content(projects);
        });
  }

  _content(lista) {
    return ListView.builder(
        itemCount: lista != null ? lista.length : 0,
        itemBuilder: (ctx, i) {
          Projects l = lista[i];
          return _projectsItems(l.projectName, l.description, ctx,
              l.userAdminId, l.id, l.categoryId);
        });
  }

  Widget _projectsItems(String projectName, String projectDescription,
      BuildContext context, int userAdminId, int projId, int catProjId) {
    return ListTile(
      contentPadding: EdgeInsets.all(15),
      leading: Card(
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
                    projectDescription: projectDescription,
                    isUserAdmin: true,
                    projectId: projId,
                    projectUserAdminId: userAdminId,
                    projectCategoryId: catProjId,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      trailing: InkWell(
        child: Text(
          'Ver inscritos >',
          style: TextStyle(
            color: Color(0xFF583D72),
            decoration: TextDecoration.underline,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => MyEnrolledPage(
                projectId: projId,
              ),
            ),
          );
        },
      ),
      title: InkWell(
        child: Text(
          projectName,
          overflow: TextOverflow.visible,
          style: TextStyle(
              // color: Color(0xFF583D72),
              // decoration: TextDecoration.underline,
              ),
        ),
        onTap: () {
          push(
            context,
            ProjectsDetails(
                imageProject: 'assets/img/docProj.png',
                nameProject: projectName,
                projectDescription: projectDescription),
          );
        },
      ),
      subtitle: Text(projectDescription,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.justify),

      /* onTap: () {
        push(
            context,
            ProjectsDetails(
                imageProject: 'assets/img/docProj.png',
                nameProject: projectName));
      },*/
    );
  }
}
