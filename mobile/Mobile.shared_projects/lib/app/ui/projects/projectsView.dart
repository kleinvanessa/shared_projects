import 'package:flutter/material.dart';
import 'package:shared_projects/app/models/project.dart';
import 'package:shared_projects/app/services/apiResponse.dart';
import 'package:shared_projects/app/ui/authentication/login.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/resources/drawer.dart';
import 'package:shared_projects/app/ui/projects/ProjectsAPI.dart';
import 'package:shared_projects/app/ui/projects/projectDetails.dart';
import 'package:shared_projects/app/utils/alert.dart';
import 'package:shared_projects/app/utils/nav.dart';

class ProjectsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var lista = _projectsList();
    return Layout.render(
      tittlePage: 'Projetos',
      drawerComponent: DrawerPage(),
      content: _projectsList(context),
    );
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
          //print("l[$i]:$l");
          return Column(
            children: <Widget>[
              i == 0
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
                                borderSide:
                                    BorderSide(color: Color(0xFF583D72)),
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
                  : _projectsItems(l.projectName, l.description, ctx),
            ],
          );
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
                  ),
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
            ProjectsDetails(
              imageProject: 'assets/img/docProj.png',
              nameProject: projectName,
            ),
          );
        },
        icon: Icon(Icons.favorite),
      ),
      title: Text(
        projectName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        projectDescription,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
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
