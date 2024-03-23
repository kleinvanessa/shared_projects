import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_projects/app/models/project.dart';
import 'package:shared_projects/app/models/user.dart';
import 'package:shared_projects/app/models/userProjects.dart';
import 'package:shared_projects/app/services/apiResponse.dart';
import 'package:shared_projects/app/ui/favorites/favorite.dart';
import 'package:shared_projects/app/ui/projects/projectDetails.dart';
import 'package:shared_projects/app/utils/alert.dart';
import 'package:shared_projects/app/utils/nav.dart';

import '../layout.dart';
import 'ProjectsAPI.dart';
import 'mySubProjectDetails.dart';

class MySubscriptionsPage extends StatefulWidget {
  @override
  _MySubscriptionsPageState createState() => _MySubscriptionsPageState();
}

class _MySubscriptionsPageState extends State<MySubscriptionsPage> {
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
      tittlePage: 'Minhas inscrições',
      content: FutureBuilder<User>(
          future: future,
          builder: (context, snapshot) {
            User user = snapshot.data;
            return _pegarProj(user.id);
          }),
    );
  }

  _pegarProj(userId) {
    Future<List<Projects>> future = ProjectsAPI.getProjectsByUserEnroll();
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
          return _content(projects, userId);
        });
  }

  _content(lista, userId) {
    return ListView.builder(
        itemCount: lista != null ? lista.length : 0,
        itemBuilder: (ctx, i) {
          Projects l = lista[i];
          Future<int> future = ProjectsAPI.getFavoriteProject(l.id, userId);
          return FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(
                      "Error: in projectsView.dart snapshot.hasError is true with error - ${snapshot.hasError}");
                }
                if (!snapshot.hasData) {
                  //verifica s tem dados
                  // print("erooo");
                }
                // print("ueee");
                int code = snapshot.data;
                // print("code : >>>>> $code");
                return _projectsItems(l.projectName, l.description, ctx,
                    l.userAdminId, l.id, l.categoryId, code, userId);
              });
        });
  }

  Widget _projectsItems(
      String projectName,
      String projectDescription,
      BuildContext context,
      int userAdminId,
      int projId,
      int catProjId,
      isFavorite,
      int userId) {
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
                  builder: (BuildContext context) => MySubProjectsDetails(
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
      trailing: isFavorite == 200
          ? IconButton(
              iconSize: 20,
              onPressed: () {
                _clickUnFavorite(projId,
                    userId); //_clickInFavorite("", "Remover dos favoritos?", true, projId);
              },
              icon: Icon(
                Icons.favorite,
                color: Color(0xFFFF8E71),
              ),
            )
          : IconButton(
              iconSize: 20,
              onPressed: () {
                _clickFavorite(projId,
                    userId); //_clickInFavorite("", "Adicionar aos favoritos?", false, projId);
              },
              icon: Icon(
                Icons.favorite_border_outlined,
                color: Color(0xFFFF8E71),
              ),
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
            MySubProjectsDetails(
              imageProject: 'assets/img/docProj.png',
              nameProject: projectName,
              projectDescription: projectDescription,
              isUserAdmin: true,
              projectId: projId,
              projectUserAdminId: userAdminId,
              projectCategoryId: catProjId,
            ),
          );
        },
      ),
      subtitle: Text(projectDescription,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.justify),
    );
  }

  _clickFavorite(projId, userId) async {
    print("não é favorito ainda");
    ApiResponse response =
        await ProjectsAPI.addFavoriteProject(projId, userEnrollId: userId);
    if (response.ok) {
      setState(() {});
      //_AlertConfirmFavorite("", "Adicionado aos favoritos");
    }
  }

  _clickUnFavorite(projId, userId) async {
    print("é favorito");
    ApiResponse response =
        await ProjectsAPI.removeFavoriteProject(projId, userEnrollId: userId);
    if (response.ok) {
      setState(() {});
      // _AlertConfirmFavorite("", "Removido dos favoritos");
    }
  }
}
