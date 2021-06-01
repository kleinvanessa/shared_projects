import 'package:flutter/material.dart';
import 'package:shared_projects/app/resources/flatButtonComponent.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/resources/textFormComponent.dart';
//import 'package:shared_projects/app/ui/authentication/login.dart';

class RedefinePassword extends StatelessWidget {
  final _tEmail = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Layout.render(
        tittlePage: 'Redefinir Senha',
        content: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(50),
            children: <Widget>[
              Column(
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      'assets/img/password.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Digite o email cadastrado',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF583D72),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormComponent(
                    obscureText: false,
                    keyboradType: TextInputType.emailAddress,
                    validator: _validateEmail,
                    textFormContent: "exemplo@email.com",
                    labelText: 'Email de cadastro',
                    colorTextContent: Color(0xFF000000).withOpacity(.3),
                    fontSizeComponent: 16,
                    enableBorderColorComponent:
                        Color(0xFF583D72).withOpacity(.4),
                    focusedBorderColorComponent: Color(0xFF583D72),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  FlatButtonComponent(
                    routeButton: null,
                    textButton: "Solicitar nova senha",
                    buttonColor: Color(0xFF583D72),
                    onPressed: _onClick,
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  String _validateEmail(String text) {
    if (text.isEmpty) {
      return "Digite o email";
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text)) {
      return "Formato de email inválido";
    }
    return null;
  }

  void _onClick() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    String email = _tEmail.text;

    print("Email: $email");
  }
}
