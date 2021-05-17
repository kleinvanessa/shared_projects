import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/ui/home/home.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout.render(
      tittlePage: 'Login',
      content: Column(
        //mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Image.asset(
              'assets/img/shared_projects-icon.png',
              //height: 200,
              //width: 250,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            flex: 2,
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF583D72),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF000000).withOpacity(.3),
                  fontStyle: FontStyle.italic,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF583D72).withOpacity(.4),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF583D72)),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Senha',
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF000000).withOpacity(.3),
                  fontStyle: FontStyle.italic,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xFF583D72).withOpacity(.4)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF583D72)),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Esqueci minha senha',
              style: TextStyle(
                color: Color(0xFF000000).withOpacity(.4),
              ),
            ),
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
    );
  }
}
