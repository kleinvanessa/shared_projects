import 'package:flutter/material.dart';
import 'package:shared_projects/app/model/user.dart';
import 'package:shared_projects/app/services/apiResponse.dart';
import 'package:shared_projects/app/ui/authentication/loginAPI.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/utils/alert.dart';
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

  bool _showProgress = false;

  @override
  void initState() {
    super.initState();

    Future<User> future = User.get();
    future.then((User user) {
      print("user init state: $user");
      if (user != null) {
        // push(context, HomePage(), replace: true); //opçao se quiser que o user logado entre direto na HomePage
        setState(() {
          _tLogin.text = user.email;
          _tPassword.text = user.password;
        });
      }
    });
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
                /* InkWell(
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
                ),*/
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
                        push(context, RegisterView(), replace: true);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                _showProgress
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFF583D72)),
                        ),
                      )
                    : FlatButtonComponent(
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

    setState(() {
      _showProgress = true;
    });

    ApiResponse response = await LoginAPI.login(login, password);
    print(response);

    if (response.ok) {
      //ok = true se o login estiver correto - status code 200
      User user =
          response.result; //result = parse do Json retornado na consulta
      print(">>> user- login.dart: $user");
      ApiResponse responseC = await LoginAPI.getCurriculum();
      print(responseC);
      ApiResponse responseP = await LoginAPI.getPayment();
      print(responseP);
      print("USER LOGIN É ${user.id}");
      push(context, HomePage(userId: user.id), replace: true);
    } else {
      Alert(context, response.msg,
          "Aviso"); //mesnagem de erro de login - status code 404 NotFound
    }
    setState(() {
      _showProgress = false;
    });
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
