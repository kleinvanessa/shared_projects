import 'package:flutter/material.dart';
import 'package:shared_projects/app/resources/flatButtonComponent.dart';
import 'package:shared_projects/app/ui/home/home.dart';
import 'package:shared_projects/app/ui/layout.dart';

class ProjectsDetails extends StatelessWidget {
  final imageProject;
  final nameProject;
  final projectDescription;
  const ProjectsDetails(
      {@required this.imageProject,
      @required this.nameProject,
      @required this.projectDescription});
  @override
  Widget build(BuildContext context) {
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
                    imageProject,
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
                '$nameProject',
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
                "$projectDescription",
                //maxLines: 1,
                overflow: TextOverflow.visible, textAlign: TextAlign.justify,
              ), //Text('$projectDescription')
              SizedBox(
                height: 25,
              ),
              FlatButtonComponent(
                  routeButton: null,
                  textButton: "Me inscrever",
                  buttonColor: Color(0xFF583D72),
                  onPressed: _clickSubmmit),
            ],
          ),
        ],
      ),
    );
  }

  _clickSubmmit() {
    //return null;
  }
}
