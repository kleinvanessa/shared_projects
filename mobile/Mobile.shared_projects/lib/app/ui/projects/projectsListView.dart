import 'package:flutter/material.dart';
import 'package:shared_projects/app/models/project.dart';
import 'package:shared_projects/app/models/user.dart';
import 'package:shared_projects/app/services/apiResponse.dart';
import 'package:shared_projects/app/ui/favorites/favorite.dart';
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
          return _projectsItems(l.projectName, l.description, ctx,
              l.userAdminId, l.id, l.categoryId);
        });
  }

  _projectsItems(String projectName, String projectDescription,
      BuildContext context, int userAdminId, int projId, int catProjId) {
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
      trailing: IconButton(
        iconSize: 20,
        onPressed: () {
          push(
            context,
            FavoritesPage(),
          );
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
}
