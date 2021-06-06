import 'package:flutter/material.dart';
import 'package:shared_projects/app/resources/drawer.dart';
import 'package:shared_projects/app/ui/projects/projectsByCat.dart';
import 'package:shared_projects/app/ui/projects/addNewProject.dart';
import 'package:shared_projects/app/ui/projects/projectsListView.dart';

class ProjectsView extends StatefulWidget {
  @override
  _ProjectsViewState createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {
  //with SingleTickerProviderStateMixin<ProjectsView> {
  //pra não fazer requisição no service toda hora, faz uma e salva
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFF583D72)),
          title: Text(
            "Projetos",
            style: TextStyle(
              color: Color(0xFF583D72),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          bottom: TabBar(
              labelColor: Color(0xFF583D72),
              indicatorColor: Color(0xFF583D72),
              unselectedLabelColor: Color(0xFF000000).withOpacity(.3),
              tabs: [
                Tab(
                  icon: Icon(Icons.search),
                ),
                Tab(
                  icon: Icon(Icons.add),
                ),
                Tab(text: "Filtro Categoria")
              ]),
        ),
        body: TabBarView(
          children: [
            ProjectsListView(),
            AddProjectsPage(),
            ProjectsByCatPage(),
          ],
        ),
        drawer: DrawerPage(),
      ),
    );
  }
}
