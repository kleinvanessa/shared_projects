import 'package:flutter/material.dart';
import 'package:shared_projects/app/model/user.dart';
import 'package:shared_projects/app/services/apiResponse.dart';
import 'package:shared_projects/app/ui/home/home.dart';
import 'package:shared_projects/app/ui/profile/profile.dart';
import 'package:shared_projects/app/ui/profile/profileUpdateAPI.dart';
import 'package:shared_projects/app/utils/alert.dart';
import 'package:shared_projects/app/utils/nav.dart';

class MyDataPage extends StatefulWidget {
  @override
  _MyDataPageState createState() => _MyDataPageState();
}

class _MyDataPageState extends State<MyDataPage> {
  final _tName = TextEditingController();

  final _tEmail = TextEditingController();

  final _tC = TextEditingController();

  final _tLastName = TextEditingController();

  final _tdata = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    Future<User> future = User.get();
    future.then((User user) {
      print("user init state: $user");

      // push(context, HomePage(), replace: true); //opçao se quiser que o user logado entre direto na HomePage
      setState(() {
        _tName.text = user.name;
        _tEmail.text = user.email;
        _tC.text = user.contact.toString();
        _tLastName.text = user.lastName;
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
                'Nome',
                _tName,
              ),
              _formEx('Sobrenome', _tLastName),
              _formEx('Email', _tEmail),
              _formEx('Contato', _tC),

              //_formEx('Data Nasc', _tdata),
              FlatButton(
                height: 30,
                onPressed: _onClickUpdateProfile,
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

  void _onClickUpdateProfile() async {
    String firstName = _tName.text;
    String lastName = _tLastName.text;
    String email = _tEmail.text;
    String contact = _tC.text;

    bool formOk = _formKey.currentState.validate();

    if (!formOk) {
      return;
    }

    ApiResponse response =
        await ProfileUpdateAPI.updateUser(firstName, lastName, email, contact);

    print(response);

    if (response.ok) {
      //ok = true se o login estiver correto - status code 200
      User user =
          response.result; //result = parse do Json retornado na consulta
      print(">>> user- register.dart: $user");
      // push(context, ProfilePage());
      Alert(context, "Usuário atualizado com sucesso!", "");

      // initState();
      //build(context);
    } else {
      Alert(context, response.msg,
          "Aviso"); //mesnagem de erro de login - status code 404 NotFound
    }
  }
}
