import 'package:flutter/material.dart';

class MyDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _formEx('Nome'),
            _formEx('Email'),
            _formEx('Contato'),
            _formEx('CPF'),
            _formEx('Data Nasc'),
            FlatButton(
              height: 30,
              onPressed: () => null,
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
    );
  }

  Widget _formEx(String fieldName) {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
              labelText: fieldName,
              labelStyle: TextStyle(
                  color: Color(0xFF000000).withOpacity(.4), fontSize: 14),
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
}
