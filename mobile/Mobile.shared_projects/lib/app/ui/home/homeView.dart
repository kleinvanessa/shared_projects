import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/resources/drawer.dart';

class HomeView extends StatefulWidget {
  final userId;

  HomeView({
    this.userId,
  });
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout.render(
      tittlePage: 'Página Inicial',
      drawerComponent: DrawerPage(
        userId: widget.userId,
      ),
      content: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text(
                'SharedProjetcs',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF583D72),
                ),
              ),
              SizedBox(height: 100),
              Image.asset(
                'assets/img/undraw_education_f8ru.png',
                //height: 200,
                //width: 250,
              ),
              SizedBox(height: 10),
            ],
          )),
    );
  }
}
