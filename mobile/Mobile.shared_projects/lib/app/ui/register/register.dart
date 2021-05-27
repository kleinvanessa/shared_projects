import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/ui/authentication/login.dart';
import 'package:shared_projects/app/resources/textFormComponent.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout.render(
        tittlePage: 'Cadastro',
        content: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/img/create_account.png',
              ),
              SizedBox(height: 10),
              Text(
                'Criar Conta',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFFFF8E71),
                ),
              ),
              _formEx('Nome', false),
              _formEx('Sobrenome', false),
              _formEx('Email', false),
              _formEx('CPF', false),
              _formEx('Senha', true),
              SizedBox(
                height: 30,
              ),
              FlatButton(
                onPressed: () => null,
                child: Text(
                  'Cadastrar',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Color(0xFFFF8E71),
                minWidth: 200.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 70,
                  ),
                  Text('Já possui conta?'),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Color(0xFF583D72),
                          decoration: TextDecoration.underline),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage()));
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ));
  }

  Widget _formEx(String fieldName, bool obscureText) {
    return TextFormComponent(
        obscureText: obscureText,
        textFormContent: fieldName,
        colorTextContent: Color(0xFF000000).withOpacity(.3),
        fontSizeComponent: 16,
        enableBorderColorComponent: Color(0xFFFF8E71).withOpacity(.4),
        focusedBorderColorComponent: Color(0xFFFF8E71));
  }
}
