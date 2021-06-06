import 'package:flutter/material.dart';
import 'package:shared_projects/app/models/project.dart';
import 'package:shared_projects/app/models/user.dart';
import 'package:shared_projects/app/resources/flatButtonComponent.dart';
import 'package:shared_projects/app/services/apiResponse.dart';
import 'package:shared_projects/app/ui/home/home.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/ui/authentication/login.dart';
import 'package:shared_projects/app/resources/textFormComponent.dart';
import 'package:shared_projects/app/ui/projects/addNewProjectAPI.dart';
import 'package:shared_projects/app/ui/projects/projectsView.dart';
import 'package:shared_projects/app/ui/register/registerAPI.dart';
import 'package:shared_projects/app/utils/alert.dart';
import 'package:shared_projects/app/utils/nav.dart';

class AddProjectsPage extends StatefulWidget {
  @override
  _AddProjectsPageState createState() => _AddProjectsPageState();
}

class _AddProjectsPageState extends State<AddProjectsPage> {
  // with AutomaticKeepAliveClientMixin<AddProjectsPage> {
  // bool get wantKeepAlive => true;
  final _tProjectName = TextEditingController();

  final _tDescription = TextEditingController();

  final _tCategory = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _focusDescription = FocusNode();

  final _focusCategory = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    //super.build(context);
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(30),
        children: <Widget>[
          Column(
            children: <Widget>[
              Image.asset(
                'assets/img/docProj.png',
                height: 100,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Cadastrar um novo Projeto',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF583D72),
                ),
              ),
              _formEx(
                'Digite o nome do projeto',
                'Título',
                _tProjectName,
                _validateField,
                TextInputType.name,
                _focusDescription,
                null,
              ),
              _formEx(
                'Digite a descrição',
                'Descrição',
                _tDescription,
                _validateField,
                TextInputType.name,
                _focusCategory,
                _focusDescription,
              ),
              _formEx(
                'Digite a categoria',
                'Categoria',
                _tCategory,
                _validateCat,
                TextInputType.number,
                null,
                _focusCategory,
              ),
              SizedBox(
                height: 30,
              ),
              FlatButtonComponent(
                onPressed: _onClickRegisterProject,
                routeButton: null,
                textButton: "Cadastrar",
                buttonColor: Color(0xFF583D72),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _formEx(
      String fieldName,
      String labelText,
      TextEditingController controller,
      validator,
      keyBoradType,
      nextFocus,
      focusNode,
      {bool obscureText = false}) {
    return TextFormComponent(
      textInputAction: TextInputAction.next,
      nextFocus: nextFocus,
      focusNode: focusNode,
      keyboradType: keyBoradType,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      textFormContent: fieldName,
      labelText: labelText,
      colorTextContent: Color(0xFF000000).withOpacity(.3),
      fontSizeComponent: 16,
      enableBorderColorComponent: Color(0xFF583D72).withOpacity(.4),
      focusedBorderColorComponent: Color(0xFF583D72),
    );
  }

  void _onClickRegisterProject() async {
    String projectName = _tProjectName.text;
    String description = _tDescription.text;
    String category = _tCategory.text;

    bool formOk = _formKey.currentState.validate();

    if (!formOk) {
      return;
    }

    print(
        "ProjName: $projectName, Description: $description, Category: $category");

    ApiResponse response =
        await AddNewProjectAPI.addProject(projectName, description, category);

    print(response);

    if (response.ok) {
      //ok = true se o login estiver correto - status code 200
      Projects project =
          response.result; //result = parse do Json retornado na consulta
      print(">>> project- register.dart: $project");

      //push(context, AddProjectsPage(), replace: true);
      Alert(context, "Projeto cadastrado com sucesso!", "");
      _tProjectName.text = "";
      _tDescription.text = "";
      _tCategory.text = "";
    } else {
      Alert(context, response.msg,
          "Aviso"); //mesnagem de erro de login - status code 404 NotFound
    }
  }

  String _validateField(String text) {
    if (text.isEmpty) {
      return "Campo em branco";
    }
    if (text.length < 3) {
      return "Formato inválido";
    }
    return null;
  }

  String _validateCat(String text) {
    if (text.isEmpty) {
      return "Campo em branco";
    }
    if (text.length > 1) {
      return "Formato inválido";
    }
    return null;
  }
}
