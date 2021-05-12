import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            color: Color(0xFF583D72),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          minimum: const EdgeInsets.all(50),
          child: Column(
            //mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset(
                'assets/img/shared_projects-icon.png',
                height: 200,
                width: 250,
              ),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFF583D72),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF000000).withOpacity(.3),
                      fontStyle: FontStyle.italic,
                    )),
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Senha',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF000000).withOpacity(.3),
                      fontStyle: FontStyle.italic,
                    )),
              ),
              Text(
                'Esqueci minha senha',
                style: TextStyle(
                  color: Color(0xFF000000).withOpacity(.4),
                ),
              ),
              FlatButton(
                onPressed: () => null,
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
          )),
    );
  }
}
