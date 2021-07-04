import 'package:flutter/material.dart';
import 'package:shared_projects/app/resources/drawer.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/ui/projects/projectsByCat.dart';
import 'package:shared_projects/app/ui/projects/addNewProject.dart';
import 'package:shared_projects/app/ui/projects/projectsListView.dart';

class ProjectsView extends StatefulWidget {
  final userId;
  const ProjectsView({
    @required this.userId,
  });
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
    print("USER PROJETOS VIEWS É ${widget.userId}");
    return Layout.render(
      tittlePage: 'Projetos',
      drawerComponent: DrawerPage(),
      content: ProjectsListView(
        userId: widget.userId,
      ),
    );
  }
}
