import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/layout.dart';

class ProjectsDetails extends StatelessWidget {
  final imageProject;
  final nameProject;
  const ProjectsDetails({
    @required this.imageProject,
    @required this.nameProject,
  });
  @override
  Widget build(BuildContext context) {
    return Layout.render(
      tittlePage: 'Mais Informações',
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Image.asset(
                  imageProject,
                  width: 200,
                  height: 200,
                ),
                Text('$nameProject')
              ],
            )
          ],
        ),
      ),
    );
  }
}
