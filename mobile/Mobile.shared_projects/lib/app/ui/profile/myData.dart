import 'package:flutter/material.dart';
import 'package:shared_projects/app/models/user.dart';

class MyDataPage extends StatefulWidget {
  @override
  _MyDataPageState createState() => _MyDataPageState();
}

class _MyDataPageState extends State<MyDataPage> {
  final _tName = TextEditingController();

  final _tEmail = TextEditingController();

  final _tC = TextEditingController();

  final _tCpf = TextEditingController();

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
              _formEx('Email', _tEmail),
              _formEx('Contato', _tC),
              _formEx('CPF', _tCpf),
              _formEx('Data Nasc', _tdata),
              FlatButton(
                height: 30,
                onPressed: () => null,
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
}
