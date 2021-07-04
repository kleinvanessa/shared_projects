import 'package:flutter/material.dart';
import 'package:shared_projects/app/models/project.dart';
import 'package:shared_projects/app/resources/flatButtonComponent.dart';
import 'package:shared_projects/app/services/apiResponse.dart';
import 'package:shared_projects/app/ui/home/home.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/ui/projects/ProjectsAPI.dart';
import 'package:shared_projects/app/ui/projects/addNewProjectAPI.dart';
import 'package:shared_projects/app/ui/projects/myProjectsPage.dart';
import 'package:shared_projects/app/utils/alert.dart';
import 'package:shared_projects/app/utils/nav.dart';

class MyProjectsDetails extends StatefulWidget {
  final imageProject;
  final nameProject;
  final projectDescription;
  final isUserAdmin;
  final projectId;
  final projectUserAdminId;
  final projectCategoryId;
  const MyProjectsDetails({
    @required this.imageProject,
    @required this.nameProject,
    @required this.projectDescription,
    @required this.isUserAdmin,
    @required this.projectId,
    @required this.projectUserAdminId,
    @required this.projectCategoryId,
  });

  @override
  _MyProjectsDetailsState createState() => _MyProjectsDetailsState();
}

class _MyProjectsDetailsState extends State<MyProjectsDetails> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    print("------------------>  isUserAdmin = ${widget.isUserAdmin}");
    return Layout.render(
      tittlePage: 'Mais Informações',
      content: ListView(
        padding: EdgeInsets.all(15),
        children: [
          Column(
            children: <Widget>[
              Row(
                children: [
                  Image.asset(
                    widget.imageProject,
                    width: 120,
                    height: 150,
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
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.grey,
                        onPressed: _clickEdit,
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.grey,
                        onPressed: _clickTrashButton,
                      ),
                    ],
                  ),
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
            ],
          ),
        ],
      ),
    );
  }

  void _clickDelete() async {
    ApiResponse response = await ProjectsAPI.deleteProject(
      widget.projectId,
    );
    Navigator.pop(context);
    print(">>> response ---> $response");

    if (response.ok) {
      //ok = true se o login estiver correto - status code 200
      //result = parse do Json retornado na consulta
      print(">>> project delete");

      //push(context, AddProjectsPage(), replace: true);
      _AlertConfirmDelete("", "Projeto deletado com sucesso!");
    } else {
      Alert(context, response.msg,
          "Aviso"); //mesnagem de erro de login - status code 404 NotFound
    }

    // TODO: fazer um save nas prefs dos proj inscritos
  }

  void _clickTrashButton() {
    _AlertDelete(
      "Aviso:",
      "Tem certeza que deseja deleter este projeto?",
    );
  }

  void _AlertDelete(String title, String msg) {
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
                  onPressed: _clickDelete,
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

  void _AlertConfirmDelete(String title, String msg) {
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
                    push(context, HomePage(), replace: true);
                    //print("OK!!!!!!!!");
                  },
                )
              ],
            ),
          );
        });
  }

  void _clickEdit() {
    print("clicou edit");
  }
}
