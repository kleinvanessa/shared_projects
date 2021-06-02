import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/authentication/loginAPI.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/utils/nav.dart';
import 'package:shared_projects/app/ui/home/home.dart';
import 'package:shared_projects/app/ui/authentication/redefinePassword.dart';
import 'package:shared_projects/app/ui/register/register.dart';
import 'package:shared_projects/app/resources/textFormComponent.dart';
import 'package:shared_projects/app/resources/flatButtonComponent.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tLogin = TextEditingController();

  final _tPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Layout.render(
      tittlePage: 'Login',
      content: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(30),
          children: <Widget>[
            Column(
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
                  nextFocus: _focus,
                  textInputAction: TextInputAction.next,
                  keyboradType: TextInputType
                      .emailAddress, // muda o teclado para tipo email
                  validator: _validateLogin,
                  controller: _tLogin,
                  textFormContent: 'exemplo@email.com',
                  labelText: 'Email',
                  colorTextContent: Color(0xFF000000).withOpacity(.3),
                  fontSizeComponent: 16,
                  enableBorderColorComponent: Color(0xFF583D72).withOpacity(.4),
                  focusedBorderColorComponent: Color(0xFF583D72),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormComponent(
                  focusNode: _focus,
                  textInputAction: TextInputAction.next,
                  validator: _validatePassword,
                  controller: _tPassword,
                  obscureText: true,
                  textFormContent: 'Digite a senha',
                  labelText: 'Senha',
                  colorTextContent: Color(0xFF000000).withOpacity(.3),
                  fontSizeComponent: 16,
                  enableBorderColorComponent: Color(0xFF583D72).withOpacity(.4),
                  focusedBorderColorComponent: Color(0xFF583D72),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: Text(
                    'Esqueci minha senha',
                    style: TextStyle(
                      color: Color(0xFF000000).withOpacity(.4),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => RedefinePassword(),
                      ),
                    );
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
                    Text(
                      'Ainda não tem cadastro?',
                    ),
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
                            builder: (BuildContext context) => RegisterView(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                FlatButtonComponent(
                  routeButton: HomePage(),
                  textButton: "Entrar",
                  buttonColor: Color(0xFF583D72),
                  onPressed: _onClickLogin,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    String login = _tLogin.text;
    String password = _tPassword.text;

    print("Login: $login, Senha: $password");

    bool ok = await LoginAPI.login(login, password);
    print(ok);

    if (ok) {
      push(context, HomePage());
    } else {
      print("Erro de Login");
    }
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Digite o email";
    }
    if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(text)) {
      return "Formato de email inválido";
    }
    return null;
  }

  String _validatePassword(String text) {
    if (text.isEmpty) {
      return "Digite a senha";
    }
    if (text.length < 6) {
      return "A senha tem um mínimo de 6 dígitos";
    }
    return null;
  }
}
