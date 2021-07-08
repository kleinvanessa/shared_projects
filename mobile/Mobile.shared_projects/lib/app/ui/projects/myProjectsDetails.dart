import 'package:flutter/material.dart';
import 'package:shared_projects/app/model/project.dart';
import 'package:shared_projects/app/model/user.dart';
import 'package:shared_projects/app/resources/flatButtonComponent.dart';
import 'package:shared_projects/app/provider/apiResponse.dart';
import 'package:shared_projects/app/ui/home/home.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/provider/userAPI.dart';
import 'package:shared_projects/app/provider/projectsAPI.dart';
import 'package:shared_projects/app/ui/projects/editMyProject.dart';
import 'package:shared_projects/app/ui/projects/myProjectsPage.dart';
import 'package:shared_projects/app/resources/alert.dart';
import 'package:shared_projects/app/utils/nav.dart';

class MyProjectsDetails extends StatefulWidget {
  final imageProject;
  final nameProject;
  final projectDescription;
  final isUserAdmin;
  final projectId;
  final projectUserAdminId;
  final projectCategoryId;
  final userAdminProj;
  final userLoggedId;
  final projType;
  final duration;
  const MyProjectsDetails({
    @required this.imageProject,
    @required this.nameProject,
    @required this.projectDescription,
    @required this.isUserAdmin,
    @required this.projectId,
    @required this.projectUserAdminId,
    @required this.projectCategoryId,
    @required this.userAdminProj,
    @required this.userLoggedId,
    @required this.projType,
    @required this.duration,
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
    Map<String, String> _categories = {
      "1": "Ciências Exatas e da Terra",
      "2": "Lingüística, Letras e Artes",
      "3": "Engenharias",
    };

    var sub = _categories[widget.projectCategoryId.toString()];
    print("------------------>  isUserAdmin = ${widget.isUserAdmin}");
    print("------------------>  userAdminProj = ${widget.userAdminProj}");
    print("------------------>  userLoggedId = ${widget.userLoggedId}");
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
                      Text("Tipo do projeto: ${widget.projType}",
                          style: TextStyle(color: Color(0xFF583D72)),
                          textAlign: TextAlign.justify),
                      Text(
                        "Duração: ${widget.duration} meses",
                        style: TextStyle(color: Color(0xFF583D72)),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  widget.userAdminProj == widget.userLoggedId
                      ? Column(
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
                        )
                      : Text("")
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

              SizedBox(
                height: 25,
              ),

              _adminName(),
              Row(
                children: [
                  Text(
                    "Área de Conhecimento:  ",
                    style: TextStyle(
                      color: Color(0xFF583D72),
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    sub,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
              //_userBName()
            ],
          ),
        ],
      ),
    );
  }

  _adminName() {
    Future<User> future = UserAPI.getUserById(widget.userAdminProj);
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

  _userBName() {
    Future<List<User>> future = UserAPI.usersInProj(widget.projectId);
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
          List<User> user = snapshot.data;

          return _listUsers(user);
        });
  }

  _listUsers(user) {
    return ListView.builder(
        itemCount: user != null ? user.length : 0,
        itemBuilder: (ctx, i) {
          User u = user[i];
          return Text(
            "${u.name}",
            overflow: TextOverflow.visible,
          );
        });
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
    push(
        context,
        EditMyProject(
          userId: widget.userLoggedId,
          projId: widget.projectId,
          projName: widget.nameProject,
          projDesc: widget.projectDescription,
          projUserAdminId: widget.userAdminProj,
          projCatId: widget.projectCategoryId,
          projType: widget.projType,
          duration: widget.duration.toString(),
        ));
  }
}
