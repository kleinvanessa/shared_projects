import 'package:flutter/material.dart';
import 'package:shared_projects/app/models/project.dart';
import 'package:shared_projects/app/models/user.dart';
import 'package:shared_projects/app/services/apiResponse.dart';
import 'package:shared_projects/app/ui/favorites/favorite.dart';
import 'package:shared_projects/app/ui/home/home.dart';
import 'package:shared_projects/app/ui/projects/projectDetails.dart';
import 'package:shared_projects/app/utils/alert.dart';
import 'package:shared_projects/app/utils/nav.dart';

import 'ProjectsAPI.dart';

class ProjectsListView extends StatefulWidget {
  final userId;
  const ProjectsListView({
    @required this.userId,
  });
  @override
  _ProjectsListViewState createState() => _ProjectsListViewState();
}

class _ProjectsListViewState extends State<ProjectsListView> {
  // with AutomaticKeepAliveClientMixin<ProjectsListView> {
  //pra não fazer requisição no service toda hora, faz uma e salva
  // bool get wantKeepAlive => true;
  bool userAdminIsTrue = false;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    print("USER LISTVIEW PROJ É ${widget.userId}");
    // super.build(context);
    return _projectsList(context);
  }

  _projectsList(context) {
    Future<List<Projects>> future = ProjectsAPI.getProjects();
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(
                "Error: in projectsView.dart snapshot.hasError is true with error - ${snapshot.hasError}");
            return Container(
              child: Center(
                child: Alert(
                  context,
                  "Não foi possível carregar os projetos",
                  "Aviso",
                ),
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
          Future<int> future =
              ProjectsAPI.getFavoriteProject(l.id, widget.userId);
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
                    l.userAdminId, l.id, l.categoryId, code);
              });
        });
  }

  _projectsItems(
      String projectName,
      String projectDescription,
      BuildContext context,
      int userAdminId,
      int projId,
      int catProjId,
      isFavorite) {
    //var trailing =  _trailing(projId, widget.userId);
    //print("trailing is $isFavorite");
    return ListTile(
      contentPadding: EdgeInsets.all(15),
      leading: Card(
        child: Ink.image(
          image: AssetImage('assets/img/docProj.png'),
          //fit: BoxFit.cover,
          width: 90.0,
          height: 90.0,
          child: InkWell(onTap: () {
            _clicInProject(projId, projectName, projectDescription, userAdminId,
                catProjId);
          }),
        ),
      ),
      trailing: isFavorite == 200
          ? IconButton(
              iconSize: 20,
              onPressed: () {
                _clickInFavorite("", "Remover dos favoritos?", true, projId);
              },
              icon: Icon(
                Icons.favorite,
                color: Color(0xFFFF8E71),
              ),
            )
          : IconButton(
              iconSize: 20,
              onPressed: () {
                _clickInFavorite("", "Adicionar aos favoritos?", false, projId);
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
            _clicInProject(projId, projectName, projectDescription, userAdminId,
                catProjId);
          }),
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

  _clickFavorite(projId) async {
    print("não é favorito ainda");
    ApiResponse response = await ProjectsAPI.addFavoriteProject(projId,
        userEnrollId: widget.userId);
    if (response.ok) {
      _AlertConfirmFavorite("", "Adicionado aos favoritos");
    }
  }

  _clickUnFavorite(projId) async {
    print("é favorito");
    ApiResponse response = await ProjectsAPI.removeFavoriteProject(projId,
        userEnrollId: widget.userId);
    if (response.ok) {
      _AlertConfirmFavorite("", "Removido dos favoritos");
    }
  }

  _clicInProject(
      projId, projectName, projectDescription, userAdminId, catProjId) async {
    print("clic projeto id $projId com user ${widget.userId}");
    var isButton;
    var submited = false;
    ApiResponse response =
        await ProjectsAPI.getUserProject(projId, userEnrollId: widget.userId);
    if (response.ok) {
      isButton = response.ok;
    } else {
      ApiResponse responseE = await ProjectsAPI.getEnrolledProject(projId,
          userEnrollId: widget.userId);
      isButton = responseE.ok;
      print("enroleed? yesss");
      isButton ? submited = true : submited = false;
    }

    print("isbutton $isButton");
    print("submited $submited");
    push(
      context,
      ProjectsDetails(
        imageProject: 'assets/img/docProj.png',
        nameProject: projectName,
        projectDescription: projectDescription,
        isButton: isButton,
        userLog: widget.userId,
        projectId: projId,
        submited: submited,
        projectUserAdminId: userAdminId,
        projectCategoryId: catProjId,
      ),
    );
  }

  _clickInFavorite(title, msg, routeYes, projId) {
    return _AlertFavorite(title, msg, routeYes, projId);
  }

  _AlertFavorite(String title, String msg, routeYes, projId) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text(title),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  child: Text("Sim"),
                  onPressed: () {
                    routeYes
                        ? _clickUnFavorite(projId)
                        : _clickFavorite(projId);
                  },
                ),
                FlatButton(
                  child: Text("Não"),
                  onPressed: () {
                    Navigator.pop(context);
                    //print("OK!!!!!!!!");
                  },
                )
              ],
            ),
          );
        });
  }

  _AlertConfirmFavorite(String title, String msg) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text(title),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    push(context, HomePage(userId: widget.userId),
                        replace: true);
                    //print("OK!!!!!!!!");
                  },
                )
              ],
            ),
          );
        });
  }
}
