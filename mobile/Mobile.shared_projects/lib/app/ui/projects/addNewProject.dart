import 'package:flutter/material.dart';
import 'package:shared_projects/app/model/project.dart';
import 'package:shared_projects/app/model/user.dart';
import 'package:shared_projects/app/resources/drawer.dart';
import 'package:shared_projects/app/resources/flatButtonComponent.dart';
import 'package:shared_projects/app/provider/apiResponse.dart';
import 'package:shared_projects/app/ui/home/home.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/ui/authentication/login.dart';
import 'package:shared_projects/app/resources/textFormComponent.dart';
import 'package:shared_projects/app/ui/projects/addNewProjectAPI.dart';
import 'package:shared_projects/app/ui/projects/projectsView.dart';
import 'package:shared_projects/app/resources/alert.dart';
import 'package:shared_projects/app/utils/nav.dart';

class AddProjectsPage extends StatefulWidget {
  final userId;

  AddProjectsPage({
    this.userId,
  });
  @override
  _AddProjectsPageState createState() => _AddProjectsPageState();
}

class _AddProjectsPageState extends State<AddProjectsPage> {
  // with AutomaticKeepAliveClientMixin<AddProjectsPage> {
  // bool get wantKeepAlive => true;
  final _tProjectName = TextEditingController();

  final _tDescription = TextEditingController();

  final _tCategory = TextEditingController();

  final _tType = TextEditingController();

  final _tDuration = TextEditingController();

  //final _tValue = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _focusDescription = FocusNode();

  final _focusCategory = FocusNode();

  final _focusType = FocusNode();

  final _focusDuration = FocusNode();

  //final _focusCategory = FocusNode();

  Map<String, String> categories = {
    "Ciências Exatas e da Terra": "1",
    "Lingüística, Letras e Artes": "2",
    "Engenharias": "3",
  };

  String dropdownValue = 'Selecione a categoria';
  var itemSelect;

  @override
  void initState() {
    dropdownValue = 'Selecione a categoria';
    itemSelect = 0;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Layout.render(
      tittlePage: 'Adicionar projeto',
      drawerComponent: DrawerPage(
        userId: widget.userId,
      ),
      content: _addProject(),
    );

    //super.build(context);
  }

  _addProject() {
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
                _focusType,
                _focusDescription,
              ),
              _formEx(
                'Digite o tipo (Pesquisa, Extensão, etc ...)',
                'Tipo de Projeto',
                _tType,
                _validateField,
                TextInputType.name,
                _focusDuration,
                _focusType,
              ),
              _formEx(
                'Digite a duração em meses (numero inteiro)',
                'Duração',
                _tDuration,
                _validateFieldDuration,
                TextInputType.number,
                _focusCategory,
                _focusDuration,
              ),
              /* _formEx(
                'Digite o valor',
                'Valor',
                _tDuration,
                _validateFieldDuration,
                TextInputType.number,
                _focusCategory,
                _focusDescription,
              ),*/
              _dropDown(),
              //  _tCategory.text = itemSelect,
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

  _dropDown() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: DropdownButtonFormField<String>(
        value: dropdownValue,
        //icon: const Icon(Icons.arrow_downward),
        //iconSize: 24,
        elevation: 2,
        style: const TextStyle(color: Colors.deepPurple),
        //underline: Container(
        //height: 2,
        //   color: Colors.deepPurpleAccent,
        // ),
        validator: _validateCat,
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;

            //itemSelect = int.parse(newValue);
            var teste = categories[newValue];
            print("esse é um teste: $teste");
            itemSelect = teste;
          });
        },
        items: <String>[
          'Selecione a categoria',
          'Ciências Exatas e da Terra',
          'Lingüística, Letras e Artes',
          'Engenharias'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
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
    String category = itemSelect;
    String projType = _tType.text;
    String duration = _tDuration.text;

    bool formOk = _formKey.currentState.validate();

    if (!formOk) {
      return;
    }

    print(
        "ProjName: $projectName, Description: $description, Category: $category");

    ApiResponse response = await AddNewProjectAPI.addProject(
        projectName, description, category, projType, duration);

    print(response);

    if (response.ok) {
      //ok = true se o login estiver correto - status code 200
      Projects project =
          response.result; //result = parse do Json retornado na consulta
      print(">>> project- register.dart: $project");

      //push(context, AddProjectsPage(), replace: true);
      //push(          context,          HomePage(            userId: widget.userId,          ),          replace: true);

      Alert(context, "Projeto cadastrado com sucesso!", "");
      setState(() {
        _tProjectName.text = "";
        _tDescription.text = "";
        _tCategory.text = "";
        _tType.text = "";
        _tDuration.text = "";
        itemSelect = "0";
        dropdownValue = "Selecione a categoria";
      });
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

  String _validateFieldDuration(String text) {
    if (text.isEmpty) {
      return "Campo em branco";
    }
    return null;
  }

  String _validateCat(String item) {
    if (item == null || item == 'Selecione a categoria') {
      return "Selecione uma categoria!";
    }
    return null;
  }
}
