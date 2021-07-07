import 'package:flutter/material.dart';
import 'package:shared_projects/app/model/curriculum.dart';
import 'package:shared_projects/app/model/project.dart';
import 'package:shared_projects/app/resources/circleAvatar.dart';
import 'package:shared_projects/app/resources/flatButtonComponent.dart';
import 'package:shared_projects/app/services/apiResponse.dart';
import 'package:shared_projects/app/ui/authentication/loginAPI.dart';
import 'package:shared_projects/app/ui/home/home.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/ui/projects/ProjectsAPI.dart';
import 'package:shared_projects/app/ui/projects/addNewProjectAPI.dart';
import 'package:shared_projects/app/ui/projects/mySubscriptions.dart';
import 'package:shared_projects/app/utils/alert.dart';
import 'package:shared_projects/app/utils/nav.dart';

class ViewCurriculum extends StatefulWidget {
  final userName;
  final userLastname;
  final userEmail;
  final userId;
  final projectId;
  final projName;
  final projDesc;
  final projCat;
  final image;
  const ViewCurriculum({
    @required this.userName,
    @required this.userLastname,
    @required this.userEmail,
    @required this.userId,
    @required this.projectId,
    @required this.projName,
    @required this.projDesc,
    @required this.projCat,
    @required this.image,
  });

  @override
  _ViewCurriculum createState() => _ViewCurriculum();
}

class _ViewCurriculum extends State<ViewCurriculum> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Layout.render(
      tittlePage: 'Curriculo',
      content: ListView(padding: EdgeInsets.all(15), children: [
        Column(
          children: [
            Text(
              '${widget.userName + " " + widget.userLastname}',
              style: TextStyle(
                color: Color(0xFF583D72),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CircularAvatar(isButton: false, image: widget.image),
            SizedBox(
              height: 20,
            ),
            Text(
              "${widget.userEmail}",
              //maxLines: 1,
              overflow: TextOverflow.visible, textAlign: TextAlign.justify,
            ), //Text('$projectDescription')
            SizedBox(
              height: 25,
            ),

            Text(
              'Curriculo',
              style: TextStyle(
                color: Color(0xFF583D72),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            // _getCurriculum(widget.userId)
            _content(),
          ],
        ),
      ]),
    );
  }

  _getCurriculum(curriculum) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Instituição :  ",
              style: TextStyle(
                color: Color(0xFF583D72),
                fontSize: 13,
              ),
            ),
            curriculum == null ? Text("") : Text("${curriculum.institution}"),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          children: [
            Text(
              "Curso :  ",
              style: TextStyle(
                color: Color(0xFF583D72),
                fontSize: 13,
              ),
            ),
            curriculum == null ? Text("") : Text("${curriculum.course}"),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          children: [
            Text(
              "Atividades :  ",
              style: TextStyle(
                color: Color(0xFF583D72),
                fontSize: 13,
              ),
            ),
            curriculum == null
                ? Text("")
                : Text(
                    "${curriculum.activites}",
                    overflow: TextOverflow.visible,
                  ),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        FlatButtonComponent(
            routeButton: _clickSelectUser,
            textButton: "Selecionar curriculo",
            buttonColor: Color(0xFF583D72),
            onPressed: _clickSelectUser),
      ],
    );
  }

  _clickSelectUser() async {
    ApiResponse response = await ProjectsAPI.addCurriculumInProject(
        widget.projectId,
        widget.projName,
        widget.projDesc,
        widget.userId,
        widget.projCat);
    if (response.ok) {
      //ok = true se o login estiver correto - status code 200
      ApiResponse responseD = await ProjectsAPI.deleteEnrollProject(
          widget.projectId,
          userEnrollId: widget.userId);
      _AlertMsg("", "Curriculo selecionado");
    } else {
      Alert(context, response.msg,
          "Aviso"); //mesnagem de erro de login - status code 404 NotFound
    }
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

  _content() {
    Future<Curriculum> future = LoginAPI.getCurriculumUser(widget.userId);

    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            //verifica s tem dados
            return _getCurriculum(null);
          }
          Curriculum curriculum = snapshot.data;
          return _getCurriculum(curriculum);
        });
  }
}
