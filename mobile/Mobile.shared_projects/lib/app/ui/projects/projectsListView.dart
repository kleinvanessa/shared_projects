import 'package:flutter/material.dart';
import 'package:shared_projects/app/models/project.dart';
import 'package:shared_projects/app/ui/favorites/favorite.dart';
import 'package:shared_projects/app/ui/projects/projectDetails.dart';
import 'package:shared_projects/app/utils/alert.dart';
import 'package:shared_projects/app/utils/nav.dart';

import 'ProjectsAPI.dart';

class ProjectsListView extends StatefulWidget {
  @override
  _ProjectsListViewState createState() => _ProjectsListViewState();
}

class _ProjectsListViewState extends State<ProjectsListView> {
  // with AutomaticKeepAliveClientMixin<ProjectsListView> {
  //pra não fazer requisição no service toda hora, faz uma e salva
  // bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
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
    //print("response aqui:  $response");
  }

  _content(lista) {
    return ListView.builder(
        itemCount: lista != null ? lista.length : 0,
        itemBuilder: (ctx, i) {
          Projects l = lista[i];
          return i == 0
              ? Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      child: TextFormField(
                        decoration: InputDecoration(
                          suffixIcon:
                              Icon(Icons.search, color: Color(0xFF583D72)),
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
                    SizedBox(
                      height: 30,
                    ),
                    _projectsItems(l.projectName, l.description, ctx)
                  ],
                )
              : _projectsItems(l.projectName, l.description, ctx);
        });
  }

  Widget _projectsItems(
      String projectName, String projectDescription, BuildContext context) {
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
                      projectDescription: projectDescription),
                ),
              );
            },
          ),
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
