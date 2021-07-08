import 'package:flutter/material.dart';
import 'package:shared_projects/app/model/payment.dart';
import 'package:shared_projects/app/model/user.dart';
import 'package:shared_projects/app/provider/apiResponse.dart';
import 'package:shared_projects/app/provider/userAPI.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _tBank = TextEditingController();

  final _tAg = TextEditingController();

  final _tAccount = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();

    Future<Payment> future = Payment.get();
    future.then((Payment payment) {
      print("payment init state: $payment");

      // push(context, HomePage(), replace: true); //opçao se quiser que o user logado entre direto na HomePage
      setState(() {
        _tBank.text = payment.bank;
        _tAg.text = payment.agency.toString();
        _tAccount.text = payment.account.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _formEx(
                  'Banco',
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                  _tBank),
              _formEx(
                  'Agência',
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                  _tAg),
              _formEx(
                  'Conta',
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                  _tAccount),
              FlatButton(
                height: 30,
                onPressed: _onClickUpdatePayment,
                child: Text(
                  'Atualizar',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Color(0xFF583D72),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _formEx(String fieldName, EdgeInsetsGeometry paddingContent, cont) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: cont,
          decoration: InputDecoration(
              contentPadding: paddingContent,
              labelText: fieldName,
              labelStyle: TextStyle(
                color: Color(0xFF000000).withOpacity(.4),
                fontSize: 14,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Color(0xFF583D72).withOpacity(.4)),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Color(0xFF583D72)),
                borderRadius: BorderRadius.circular(15),
              )),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  void _onClickUpdatePayment() async {
    print("onclick");
    String bank = _tBank.text;
    String ag = _tAg.text;
    String account = _tAccount.text;
    print("dados : $bank $ag $account");
    bool formOk = _formKey.currentState.validate();

    if (!formOk) {
      return;
    }

    ApiResponse response = await UserAPI.updateUserPayment(bank, ag, account);

    print(response);
  }
}
