import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/ui/authentication/login.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout.render(
        tittlePage: 'Cadastro',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Image.asset(
                'assets/img/create_account.png',
                //height: 200,
                //width: 250,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 2,
              child: Text(
                'Criar Conta',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFFFF8E71),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Nome',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF000000).withOpacity(.3),
                    fontStyle: FontStyle.italic,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFFF8E71).withOpacity(.4),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFF8E71)),
                  ),
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
                      color: Color(0xFFFF8E71).withOpacity(.4),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFF8E71)),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'CPF',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF000000).withOpacity(.3),
                    fontStyle: FontStyle.italic,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFFF8E71).withOpacity(.4),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFF8E71)),
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
                        BorderSide(color: Color(0xFFFF8E71).withOpacity(.4)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFF8E71)),
                  ),
                ),
              ),
            ),
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
                Expanded(flex: 0, child: Text('Já possui conta?')),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 0,
                  child: InkWell(
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
                ),
              ],
            ),
            SizedBox(
              height: 50,
            )
          ],
        ));
  }
}
