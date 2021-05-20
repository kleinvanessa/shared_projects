import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/ui/home/home.dart';
import 'package:shared_projects/app/ui/authentication/redefinePassword.dart';
import 'package:shared_projects/app/ui/register/register.dart';
import 'package:shared_projects/app/resources/textFormComponent.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout.render(
      tittlePage: 'Login',
      content: SingleChildScrollView(
        child: Column(
          //mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset(
              'assets/img/shared_projects-icon.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 10),
            Text(
              'Login',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF583D72),
              ),
            ),
            TextFormComponent(
                textFormContent: 'Email',
                colorTextContent: Color(0xFF000000).withOpacity(.3),
                fontSizeComponent: 16,
                enableBorderColorComponent: Color(0xFF583D72).withOpacity(.4),
                focusedBorderColorComponent: Color(0xFF583D72)),
            SizedBox(
              height: 10,
            ),
            TextFormComponent(
                textFormContent: 'Senha',
                colorTextContent: Color(0xFF000000).withOpacity(.3),
                fontSizeComponent: 16,
                enableBorderColorComponent: Color(0xFF583D72).withOpacity(.4),
                focusedBorderColorComponent: Color(0xFF583D72)),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Text(
                'Esqueci minha senha',
                style: TextStyle(
                    color: Color(0xFF000000).withOpacity(.4),
                    decoration: TextDecoration.underline),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => RedefinePassword()));
              },
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 25,
                ),
                Text('Ainda não tem cadastro?'),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: Text(
                    'Cadastre-se',
                    style: TextStyle(
                        color: Color(0xFFFF8E71),
                        decoration: TextDecoration.underline),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => RegisterView()));
                  },
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text(
                'Entrar',
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
      ),
    );
  }
}
