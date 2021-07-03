import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_projects/app/models/project.dart';
import 'package:shared_projects/app/models/user.dart';
import 'package:shared_projects/app/models/userProjects.dart';
import 'package:shared_projects/app/resources/circleAvatar.dart';
import 'package:shared_projects/app/ui/chat/chatAPI.dart';
import 'package:shared_projects/app/ui/favorites/favorite.dart';
import 'package:shared_projects/app/ui/projects/projectDetails.dart';
import 'package:shared_projects/app/utils/alert.dart';
import 'package:shared_projects/app/utils/nav.dart';

import '../layout.dart';
import 'ProjectsAPI.dart';

class MyEnrolledPage extends StatefulWidget {
  final projectId;
  const MyEnrolledPage({
    @required this.projectId,
  });
  @override
  _MyEnrolledPageState createState() => _MyEnrolledPageState();
}

class _MyEnrolledPageState extends State<MyEnrolledPage> {
  // with AutomaticKeepAliveClientMixin<ProjectsListView> {
  //pra não fazer requisição no service toda hora, faz uma e salva
  // bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    //super.build(context);
    return Layout.render(
      tittlePage: 'Meus inscritos',
      content: _usersList(),
    );
  }

  _usersList() {
    Future<List<User>> future = ProjectsAPI.usersEnrolls(widget.projectId);
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
          List<User> users = snapshot.data;
          return _content(
            users,
          );
        });
    //print("response aqui:  $response");
  }

  _content(users) {
    return ListView.builder(
      itemCount: users != null ? users.length : 0,
      itemBuilder: (ctx, i) {
        User u = users[i];
        return _userTile(
          u.name,
          u.lastName,
          u.email,
        );
      },
    );
  }

  _userTile(String name, String lastName, email, {urlFoto}) {
    return ListTile(
      leading: CircularAvatar(
        isButton: false,
        image: urlFoto ?? "assets/img/undefined.png",
      ),
      title: Text(
        name + " " + lastName,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: Text(
        email,
      ),
    );
  }
}