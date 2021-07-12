import 'package:flutter/material.dart';
import 'package:shared_projects/app/model/user.dart';
import 'package:shared_projects/app/provider/userAPI.dart';
import 'package:shared_projects/app/resources/flatButtonComponent.dart';
import 'package:shared_projects/app/provider/apiResponse.dart';
import 'package:shared_projects/app/ui/home/home.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/ui/authentication/login.dart';
import 'package:shared_projects/app/resources/textFormComponent.dart';
import 'package:shared_projects/app/resources/alert.dart';
import 'package:shared_projects/app/utils/nav.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _tFirstName = TextEditingController();

  final _tLastName = TextEditingController();

  final _tEmail = TextEditingController();

  final _tContact = TextEditingController();

  final _tPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _focusLastName = FocusNode();

  final _focusEmail = FocusNode();

  final _focusContact = FocusNode();

  final _focusPassword = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Layout.render(
        tittlePage: 'Cadastro',
        content: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(30),
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.asset(
                    'assets/img/create_account.png',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Criar Conta',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFFFF8E71),
                    ),
                  ),
                  _formEx(
                    'Digite seu primeiro nome',
                    'Nome',
                    _tFirstName,
                    _validateName,
                    TextInputType.name,
                    _focusLastName,
                    null,
                  ),
                  _formEx(
                    'Digite seu sobrenome',
                    'Sobrenome',
                    _tLastName,
                    _validateName,
                    TextInputType.name,
                    _focusEmail,
                    _focusLastName,
                  ),
                  _formEx(
                    'email@exemplo.com',
                    'Email',
                    _tEmail,
                    _validateEmail,
                    TextInputType.emailAddress,
                    null,
                    _focusEmail,
                  ),
                  _formEx(
                    '51999999999',
                    'Contato',
                    _tContact,
                    _validateName,
                    TextInputType.number,
                    null,
                    _focusContact,
                  ),
                  _formEx(
                      'Digite a senha',
                      'Senha',
                      _tPassword,
                      _validatePassword,
                      TextInputType.name,
                      null,
                      _focusPassword,
                      obscureText: true),
                  SizedBox(
                    height: 30,
                  ),
                  FlatButtonComponent(
                    onPressed: _onClickRegister,
                    routeButton: null,
                    textButton: "Cadastrar",
                    buttonColor: Color(0xFFFF8E71),
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 70,
                      ),
                      Text(
                        'Já possui conta?',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: Text(
                          'Entrar',
                          style: TextStyle(
                            color: Color(0xFF583D72),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () {
                          push(context, LoginPage(), replace: true);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _formEx(
      String fieldName,
      String labelText,
      TextEditingController controller,
      validator,
      keyBoradType,
      nextFocus,
      focusNode,
      {bool obscureText = false}) {
    return TextFormComponent(
      textInputAction: TextInputAction.next,
      nextFocus: nextFocus,
      focusNode: focusNode,
      keyboradType: keyBoradType,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      textFormContent: fieldName,
      labelText: labelText,
      colorTextContent: Color(0xFF000000).withOpacity(.3),
      fontSizeComponent: 16,
      enableBorderColorComponent: Color(0xFFFF8E71).withOpacity(.4),
      focusedBorderColorComponent: Color(0xFFFF8E71),
    );
  }

  void _onClickRegister() async {
    String firstName = _tFirstName.text;
    String lastName = _tLastName.text;
    String email = _tEmail.text;
    String password = _tPassword.text;
    String contact = _tContact.text;

    bool formOk = _formKey.currentState.validate();

    if (!formOk) {
      return;
    }

    print(
      "FirstName: $firstName, LastName: $lastName, Email: $email, Senha: $password",
    );

    ApiResponse response =
        await UserAPI.register(firstName, lastName, email, contact, password);

    print(response);

    if (response.ok) {
      //ok = true se o login estiver correto - status code 200
      User user =
          response.result; //result = parse do Json retornado na consulta
      print(">>> user- register.dart: $user");

      push(context, HomePage(), replace: true);
      Alert(context, "Usuário cadastrado com sucesso!", "Seja Bem-vindo!");
    } else {
      Alert(context, response.msg,
          "Aviso"); //mesnagem de erro de login - status code 404 NotFound
    }
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

  String _validateName(String text) {
    if (text.isEmpty) {
      return "Campo em branco";
    }
    if (text.length < 3) {
      return "Formato inválido";
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
