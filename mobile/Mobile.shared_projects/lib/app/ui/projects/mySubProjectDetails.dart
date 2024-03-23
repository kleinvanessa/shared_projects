import 'package:flutter/material.dart';
import 'package:shared_projects/app/models/project.dart';
import 'package:shared_projects/app/models/user.dart';
import 'package:shared_projects/app/resources/flatButtonComponent.dart';
import 'package:shared_projects/app/services/apiResponse.dart';
import 'package:shared_projects/app/ui/home/home.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/ui/profile/profileUpdateAPI.dart';
import 'package:shared_projects/app/ui/projects/ProjectsAPI.dart';
import 'package:shared_projects/app/ui/projects/addNewProjectAPI.dart';
import 'package:shared_projects/app/ui/projects/mySubscriptions.dart';
import 'package:shared_projects/app/utils/alert.dart';
import 'package:shared_projects/app/utils/nav.dart';

class MySubProjectsDetails extends StatefulWidget {
  final imageProject;
  final nameProject;
  final projectDescription;
  final isUserAdmin;
  final projectId;
  final projectUserAdminId;
  final projectCategoryId;
  const MySubProjectsDetails({
    @required this.imageProject,
    @required this.nameProject,
    @required this.projectDescription,
    @required this.isUserAdmin,
    @required this.projectId,
    @required this.projectUserAdminId,
    @required this.projectCategoryId,
  });

  @override
  _MySubProjectsDetailsState createState() => _MySubProjectsDetailsState();
}

class _MySubProjectsDetailsState extends State<MySubProjectsDetails> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Layout.render(
      tittlePage: 'Minhas inscrições',
      content: ListView(
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
              _adminName(),
              SizedBox(
                height: 25,
              ),
              FlatButtonComponent(
                  routeButton: _clickCancelEnroll,
                  textButton: "Cancelar inscrição",
                  buttonColor: Color(0xFF583D72),
                  onPressed: _clickCancelEnroll),
            ],
          ),
        ],
      ),
    );
  }

  void _clickSubmmit() async {
    ApiResponse response = await ProjectsAPI.deleteEnrollProject(
      widget.projectId,
    );
    Navigator.pop(context);
    print(">>> response ---> $response");

    if (response.ok) {
      //ok = true se o login estiver correto - status code 200
      //result = parse do Json retornado na consulta
      print(">>> project delte enroll");

      //push(context, AddProjectsPage(), replace: true);
      _AlertMsg("", "Cancelada inscrição");
    } else {
      Alert(context, response.msg,
          "Aviso"); //mesnagem de erro de login - status code 404 NotFound
    }
    // TODO: fazer um save nas prefs dos proj inscritos
  }

  void _clickCancelEnroll() {
    _AlertDelete(
        "Aviso", "Tem certeza que deseja cancelar a inscrição no projeto?");
  }

  void _AlertMsg(title, msg) {
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
                /* FlatButton(
                child: Text("cancelar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),*/
                FlatButton(
                  child: Text("ok"),
                  onPressed: () {
                    push(context, HomePage(), replace: true);
                    //print("OK!!!!!!!!");
                  },
                ),
              ],
            ),
          );
        });
  }

  _adminName() {
    Future<User> future =
        ProfileUpdateAPI.getUserById(widget.projectUserAdminId);
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
          User user = snapshot.data;

          return Row(
            children: [
              Text(
                "Coordenador do Projeto:  ",
                style: TextStyle(
                  color: Color(0xFF583D72),
                  fontSize: 13,
                ),
              ),
              Text(
                "${user.name + " " + user.lastName}",
                overflow: TextOverflow.visible,
              ),
            ],
          );
        });
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
                  onPressed: _clickSubmmit,
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
}
