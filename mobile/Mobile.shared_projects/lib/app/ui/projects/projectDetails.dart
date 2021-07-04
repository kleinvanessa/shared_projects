import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_projects/app/models/project.dart';
import 'package:shared_projects/app/resources/flatButtonComponent.dart';
import 'package:shared_projects/app/services/apiResponse.dart';
import 'package:shared_projects/app/ui/home/home.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/ui/projects/ProjectsAPI.dart';
import 'package:shared_projects/app/ui/projects/addNewProjectAPI.dart';
import 'package:shared_projects/app/ui/projects/projectsView.dart';
import 'package:shared_projects/app/utils/alert.dart';
import 'package:shared_projects/app/utils/nav.dart';

class ProjectsDetails extends StatefulWidget {
  final imageProject;
  final nameProject;
  final projectDescription;
  final userLog;
  final projectId;
  final projectUserAdminId;
  final projectCategoryId;
  final isButton;
  const ProjectsDetails({
    @required this.imageProject,
    @required this.nameProject,
    @required this.projectDescription,
    @required this.userLog,
    @required this.projectId,
    @required this.projectUserAdminId,
    @required this.projectCategoryId,
    @required this.isButton,
  });

  @override
  _ProjectsDetailsState createState() => _ProjectsDetailsState();
}

class _ProjectsDetailsState extends State<ProjectsDetails> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    //print("------------------>  isUserAdmin = ${widget.userLog}");

    return Layout.render(
      tittlePage: 'Mais Informações',
      content: _content(),
    );
  }

  _content() {
    return ListView(
      padding: EdgeInsets.all(15),
      children: [
        Column(
          children: <Widget>[
            Row(
              children: [
                Image.asset(
                  widget.imageProject,
                  width: 150,
                  height: 200,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text("Projeto de Pesquisa",
                        style: TextStyle(color: Color(0xFF583D72)),
                        textAlign: TextAlign.justify),
                    Text(
                      "Duração: 1 ano",
                      style: TextStyle(color: Color(0xFF583D72)),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "Início: 20/01/21",
                      style: TextStyle(color: Color(0xFF583D72)),
                    ),
                    Text(
                      "Remuneração: RS 400,00",
                      style: TextStyle(color: Color(0xFF583D72)),
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.favorite_border_outlined,
                  color: Color(0xFFFF8E71),
                )
              ],
            ),
            Text(
              '${widget.nameProject}',
              style: TextStyle(
                color: Color(0xFF583D72),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Descrição",
              style: TextStyle(
                color: Color(0xFF583D72),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${widget.projectDescription}",
              //maxLines: 1,
              overflow: TextOverflow.visible, textAlign: TextAlign.justify,
            ), //Text('$projectDescription')
            SizedBox(
              height: 25,
            ),
            widget.isButton
                ? Text("teste")
                : FlatButtonComponent(
                    //routeButton: _clickSubmmit,
                    textButton: "Me inscrever",
                    buttonColor: Color(0xFF583D72),
                    onPressed: _clickSubmmit),
            //_getUserProjCode(code),
            /*widget.userLog == widget.projectUserAdminId
                  ? Container()
                  : FlatButtonComponent(
                      routeButton: _clickSubmmit,
                      textButton: "Me inscrever",
                      buttonColor: Color(0xFF583D72),
                      onPressed: _clickSubmmit),*/
          ],
        ),
      ],
    );
  }

  void _clickSubmmit() async {
    ApiResponse response = await ProjectsAPI.enroolProject(
        widget.projectId,
        widget.nameProject,
        widget.projectDescription,
        widget.projectUserAdminId,
        widget.projectCategoryId);
    print(">>> response ---> $response");

    if (response.ok) {
      //ok = true se o login estiver correto - status code 200
      Projects project =
          response.result; //result = parse do Json retornado na consulta
      print(">>> project- register.dart: $project");

      //push(context, AddProjectsPage(), replace: true);
      push(context, ProjectsView(userId: widget.userLog), replace: true);
      Alert(context, "Inscrição feita com sucesso!", "");
    } else {
      Alert(context, response.msg,
          "Aviso"); //mesnagem de erro de login - status code 404 NotFound
    }
    // TODO: fazer um save nas prefs dos proj inscritos
  }
}
