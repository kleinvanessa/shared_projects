import 'package:flutter/material.dart';
import 'package:shared_projects/app/model/user.dart';
import 'package:shared_projects/app/provider/apiResponse.dart';
import 'package:shared_projects/app/ui/home/home.dart';
import 'package:shared_projects/app/ui/profile/profile.dart';
import 'package:shared_projects/app/provider/userAPI.dart';
import 'package:shared_projects/app/provider/projectsAPI.dart';
import 'package:shared_projects/app/resources/alert.dart';
import 'package:shared_projects/app/utils/nav.dart';

import '../layout.dart';

class EditMyProject extends StatefulWidget {
  final userId;
  final projId;
  final projName;
  final projDesc;
  final projUserAdminId;
  final projCatId;
  final projType;
  final duration;
  const EditMyProject({
    @required this.userId,
    @required this.projId,
    @required this.projName,
    @required this.projDesc,
    @required this.projUserAdminId,
    @required this.projCatId,
    @required this.projType,
    @required this.duration,
  });
  @override
  _EditMyProject createState() => _EditMyProject();
}

class _EditMyProject extends State<EditMyProject> {
  final _tName = TextEditingController();

  final _tDesc = TextEditingController();

  final _tCat = TextEditingController();

  final _tType = TextEditingController();

  final _tDuration = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Map<String, String> categories = {
    "Ciências Exatas e da Terra": "1",
    "Lingüística, Letras e Artes": "2",
    "Engenharias": "3",
  };
  Map<String, String> _categories = {
    "1": "Ciências Exatas e da Terra",
    "2": "Lingüística, Letras e Artes",
    "3": "Engenharias",
  };
  String dropdownValue;
  var itemSelect;
  var catValue;

  @override
  void initState() {
    itemSelect = widget.projCatId;
    String number = widget.projCatId.toString();
    print("number $number");
    dropdownValue = _categories[number];
    super.initState();

    print("esse é um test: $dropdownValue  $itemSelect");
    //opçao se quiser que o user logado entre direto na HomePage
    setState(() {
      _tName.text = widget.projName;
      _tDesc.text = widget.projDesc;
      _tType.text = widget.projType;
      _tDuration.text = widget.duration;

      itemSelect = widget.projCatId;
      catValue = widget.projCatId.toString();
    });

    // });
  }

  Widget build(BuildContext context) {
    return Layout.render(
      tittlePage: 'Editar Projeto',
      content: ListView(padding: EdgeInsets.all(15), children: [
        Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _formEx(
                  'Título do projeto',
                  _tName,
                ),
                _formEx('Descrição', _tDesc),
                _formEx('Tipo de Projeto', _tType),
                _formEx('Duração em meses', _tDuration),
                _dropDown(),

                //_formEx('Data Nasc', _tdata),
                FlatButton(
                  height: 30,
                  onPressed: _onClickUpdateProject,
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
      ]),
    );
  }

  _dropDown() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: DropdownButtonFormField<String>(
        value: dropdownValue,
        elevation: 2,
        style: const TextStyle(color: Colors.deepPurple),
        // validator: _validateCat,
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;

            //itemSelect = int.parse(newValue);
            var teste = categories[newValue];
            print("esse é um teste: $teste");
            catValue = teste;
            itemSelect = teste;
          });
        },
        items: <String>[
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

  String _validateCat(String item) {
    if (item == null || item == 'Selecione a categoria') {
      return "Selecione uma categoria!";
    }
    return null;
  }

  Widget _formEx(String fieldName, cont) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: cont,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
              labelText: fieldName,
              labelStyle: TextStyle(
                  color: Color(0xFF000000).withOpacity(.4), fontSize: 14),
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

  void _onClickUpdateProject() async {
    String projName = _tName.text;
    String projDesc = _tDesc.text;
    String projType = _tType.text;
    String projDuration = _tDuration.text;
    String projCat = catValue;

    bool formOk = _formKey.currentState.validate();

    if (!formOk) {
      return;
    }
    print("catId $projCat");
    ApiResponse response = await ProjectsAPI.updateProject(
        widget.projId,
        projName,
        projDesc,
        widget.projUserAdminId,
        projCat,
        projType,
        projDuration);

    print(response);

    if (response.ok) {
      //ok = true se o login estiver correto - status code 200

      //

      push(
          context,
          HomePage(
            userId: widget.userId,
          ));
      Alert(context, "Projeto atualizado com sucesso!", "");
      // initState();
      //build(context);
    } else {
      Alert(context, response.msg,
          "Aviso"); //mesnagem de erro de login - status code 404 NotFound
    }
  }
}
