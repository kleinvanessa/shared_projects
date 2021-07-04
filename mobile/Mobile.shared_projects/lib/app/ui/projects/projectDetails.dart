import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_projects/app/models/project.dart';
import 'package:shared_projects/app/resources/flatButtonComponent.dart';
import 'package:shared_projects/app/services/apiResponse.dart';
import 'package:shared_projects/app/ui/home/home.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/ui/projects/ProjectsAPI.dart';
import 'package:shared_projects/app/ui/projects/addNewProjectAPI.dart';
import 'package:shared_projects/app/ui/projects/myProjectsPage.dart';
import 'package:shared_projects/app/ui/projects/mySubscriptions.dart';
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
  final submited;
  const ProjectsDetails({
    @required this.imageProject,
    @required this.nameProject,
    @required this.projectDescription,
    @required this.userLog,
    @required this.projectId,
    @required this.projectUserAdminId,
    @required this.projectCategoryId,
    @required this.isButton,
    @required this.submited,
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
    print("isButton : ${widget.isButton} e submited : ${widget.submited}");
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
                ? _isSubmet()
                : FlatButtonComponent(
                    //routeButton: _clickSubmmit,
                    textButton: "Me inscrever",
                    buttonColor: Color(0xFF583D72),
                    onPressed: _clickSubmmit),
          ],
        ),
      ],
    );
  }

  _isSubmet() {
    print("isSub ${widget.submited}");

    print("ueee");
    return Column(
      children: [
        widget.submited
            ? Text("Você já está inscrito neste projeto")
            : Text("Você já faz parte deste projeto"),
        SizedBox(
          height: 25,
        ),
        InkWell(
          child: Text(
            widget.submited ? 'Ver minhas inscrições' : 'Ver meus projetos',
            style: TextStyle(
              color: widget.submited ? Color(0xFFFF8E71) : Color(0xFF583D72),
              decoration: TextDecoration.underline,
            ),
          ),
          onTap: () {
            widget.submited
                ? _click(MySubscriptionsPage())
                : _click(MyProjectsPage());
          },
        )
      ],
    );
  }

  _click(route) {
    push(context, route);
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
