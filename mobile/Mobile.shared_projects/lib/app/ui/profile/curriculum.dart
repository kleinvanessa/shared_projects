import 'package:flutter/material.dart';
import 'package:shared_projects/app/model/curriculum.dart';
import 'package:shared_projects/app/model/user.dart';
import 'package:shared_projects/app/provider/apiResponse.dart';
import 'package:shared_projects/app/provider/userAPI.dart';
import 'package:shared_projects/app/resources/alert.dart';

class CurriculumPage extends StatefulWidget {
  @override
  _CurriculumPageState createState() => _CurriculumPageState();
}

class _CurriculumPageState extends State<CurriculumPage> {
  final _tInstitution = TextEditingController();

  final _tCourse = TextEditingController();

  final _tActivites = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    Future<Curriculum> future = Curriculum.get();
    future.then((Curriculum curriculum) {
      print("curriculum init state: $curriculum");

      // push(context, HomePage(), replace: true); //opçao se quiser que o user logado entre direto na HomePage
      setState(() {
        _tInstitution.text = curriculum.institution;
        _tCourse.text = curriculum.course;
        _tActivites.text = curriculum.activites;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _formEx(
                  'Intituição',
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                  _tInstitution),
              _formEx(
                  'Curso',
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                  _tCourse),
              _formEx(
                  'Atividades',
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 12),
                  _tActivites),
              FlatButton(
                height: 30,
                onPressed: _onClickUpdateCurriculum,
                child: Text(
                  'Atualizar',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Color(0xFF583D72),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _formEx(String fieldName, EdgeInsetsGeometry paddingContent, cont) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: cont,
          decoration: InputDecoration(
              contentPadding: paddingContent,
              labelText: fieldName,
              labelStyle: TextStyle(
                color: Color(0xFF000000).withOpacity(.4),
                fontSize: 14,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Color(0xFF583D72).withOpacity(.4)),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Color(0xFF583D72)),
                borderRadius: BorderRadius.circular(15),
              )),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  void _onClickUpdateCurriculum() async {
    String institution = _tInstitution.text;
    String course = _tCourse.text;
    String activites = _tActivites.text;

    bool formOk = _formKey.currentState.validate();

    if (!formOk) {
      return;
    }

    ApiResponse response =
        await UserAPI.updateUserCurriculum(institution, course, activites);

    print(response);
  }
}
