import 'package:flutter/material.dart';
import 'package:shared_projects/app/models/project.dart';
import 'package:shared_projects/app/ui/favorites/favorite.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/ui/projects/projectDetails.dart';
import 'package:shared_projects/app/utils/alert.dart';
import 'package:shared_projects/app/utils/nav.dart';

import 'ProjectsAPI.dart';

class ProjectsByCatPage extends StatefulWidget {
  @override
  _ProjectsByCatPageState createState() => _ProjectsByCatPageState();
}

class _ProjectsByCatPageState extends State<ProjectsByCatPage>
    with AutomaticKeepAliveClientMixin<ProjectsByCatPage> {
  bool get wantKeepAlive => true;
  String dropdownValue = '1';
  var itemSelect;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    super.build(context);
    return _dropDown();

    //_projectsList(context, 1);
  }

  _dropDown() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: DropdownButton<String>(
        value: dropdownValue,
        //icon: const Icon(Icons.arrow_downward),
        //iconSize: 24,
        elevation: 2,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          //height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;

            itemSelect = int.parse(newValue);
            _projectsList(context, itemSelect);
          });
        },

        items: <String>['1', '2', '3']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  _projectsList(context, categoryId) {
    Future<List<Projects>> future =
        ProjectsAPI.getProjectsByCategory(categoryId);
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
          return _projectsItems(l.projectName, l.description, ctx);
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
      subtitle: Row(
        children: [
          Text(
            projectDescription,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
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
