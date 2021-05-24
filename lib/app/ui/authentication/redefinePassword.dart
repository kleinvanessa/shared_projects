import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/resources/textFormComponent.dart';
import 'package:shared_projects/app/ui/authentication/login.dart';

class RedefinePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout.render(
        tittlePage: 'Redefinir Senha',
        content: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Center(
                child: Image.asset(
                  'assets/img/password.png',
                  width: 200,
                  height: 200,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Digite o email cadastrado',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF583D72),
                ),
              ),
              SizedBox(height: 50),
              TextFormComponent(
                  obscureText: false,
                  textFormContent: 'Email de cadastro',
                  colorTextContent: Color(0xFF000000).withOpacity(.3),
                  fontSizeComponent: 16,
                  enableBorderColorComponent: Color(0xFF583D72).withOpacity(.4),
                  focusedBorderColorComponent: Color(0xFF583D72)),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  'Solicitar nova senha',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Color(0xFF583D72),
                minWidth: 200.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              )
            ],
          ),
        ));
  }
}
