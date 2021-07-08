import 'package:flutter/material.dart';
import 'package:shared_projects/app/model/favorite.dart';
import 'package:shared_projects/app/model/project.dart';
import 'package:shared_projects/app/provider/apiResponse.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/provider/projectsAPI.dart';
import 'package:shared_projects/app/ui/projects/projectDetails.dart';
import 'package:shared_projects/app/resources/alert.dart';
import 'package:shared_projects/app/utils/nav.dart';

class FavoritesPage extends StatefulWidget {
  final userId;
  const FavoritesPage({
    this.userId,
  });
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout.render(
      tittlePage: 'Favoritos',
      content: _getFavorites(),
    );
  }

  _getFavorites() {
    Future<List<Favorite>> future = ProjectsAPI.getAllFavorites(widget.userId);
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
            print("A");
            //verifica s tem dados
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFF583D72),
                ),
              ),
            );
          }
          List<Favorite> favorites = snapshot.data;
          return _list(favorites); //_list(favorites);
        });
  }

  _list(favorites) {
    print("favorites ${favorites.length} >>>.....;;;;;;; :");
    var l = favorites.length;
    return ListView.builder(
      itemCount: favorites != null ? l : 0,
      itemBuilder: (ctx, i) {
        Favorite f = favorites[i];
        Future<Projects> future = ProjectsAPI.getProjectsById(f.projectId);
        return FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(
                    "Error: in projectsView.dart snapshot.hasError is true with error - ${snapshot.hasError}");
              }
              if (!snapshot.hasData) {
                //verifica s tem dados
                print("erooo    ${snapshot.hasData}");
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF583D72),
                    ),
                  ),
                );
              }
              // print("ueee");
              Projects l = snapshot.data;

              // print("code : >>>>> $code");
              return l != null
                  ? _projectsItems(
                      l.projectName,
                      l.description,
                      ctx,
                      l.userAdminId,
                      l.id,
                      l.categoryId,
                      l.projectType,
                      l.duration)
                  : Container();
            });
      },
    );
  }

  _projectsItems(
      String projectName,
      String projectDescription,
      BuildContext context,
      int userAdminId,
      int projId,
      int catProjId,
      projType,
      duration) {
    Map<String, String> _categories = {
      "1": "Ciências Exatas e da Terra",
      "2": "Lingüística, Letras e Artes",
      "3": "Engenharias",
    };

    var sub = _categories[catProjId.toString()];
    return ListTile(
      contentPadding: EdgeInsets.all(15),
      leading: Card(
        child: Ink.image(
          image: AssetImage('assets/img/docProj.png'),
          //fit: BoxFit.cover,
          width: 90.0,
          height: 90.0,
          child: InkWell(onTap: () {
            _clicInProject(projId, projectName, projectDescription, userAdminId,
                catProjId, projType, duration);
          }),
        ),
      ),
      trailing: IconButton(
        iconSize: 20,
        onPressed: () {
          _clickUnFavorite(
              projId); //_clickInFavorite("", "Remover dos favoritos?", true, projId);
        },
        icon: Icon(
          Icons.favorite,
          color: Color(0xFFFF8E71),
        ),
      ),
      title: InkWell(
          child: Text(
            projectName,
            overflow: TextOverflow.visible,
            style: TextStyle(),
          ),
          onTap: () {
            _clicInProject(projId, projectName, projectDescription, userAdminId,
                catProjId, projType, duration);
          }),
      subtitle: Text(sub,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.justify),
    );
  }

  _clickUnFavorite(projId) async {
    print("é favorito");
    ApiResponse response = await ProjectsAPI.removeFavoriteProject(projId,
        userEnrollId: widget.userId);
    if (response.ok) {
      setState(() {});
      // _AlertConfirmFavorite("", "Removido dos favoritos");
    }
  }

  _clicInProject(projId, projectName, projectDescription, userAdminId,
      catProjId, projType, duration) async {
    print("clic projeto id $projId com user ${widget.userId}");
    var isButton;
    var submited = false;
    ApiResponse response =
        await ProjectsAPI.getUserProject(projId, userEnrollId: widget.userId);
    if (response.ok) {
      isButton = response.ok;
    } else {
      ApiResponse responseE = await ProjectsAPI.getEnrolledProject(projId,
          userEnrollId: widget.userId);
      isButton = responseE.ok;
      print("enroleed? yesss");
      isButton ? submited = true : submited = false;
    }

    print("isbutton $isButton");
    print("submited $submited");
    push(
      context,
      ProjectsDetails(
        imageProject: 'assets/img/docProj.png',
        nameProject: projectName,
        projectDescription: projectDescription,
        isButton: isButton,
        userLog: widget.userId,
        projectId: projId,
        submited: submited,
        projectUserAdminId: userAdminId,
        projectCategoryId: catProjId,
        projType: projType,
        duration: duration,
        isFavorite: false,
      ),
    );
  }

  _content() {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Center(
          child: Image.asset(
            'assets/img/favorite.png',
            width: 200,
            height: 200,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Nenhum favorito adicionado',
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF583D72),
          ),
        ),
      ],
    ));
  }
}
