import 'package:flutter/material.dart';

class MyDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(30),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _formEx('Nome', 'Vanessa Lopes Klein'),
            _formEx('Email', 'vanessalopesklein@gmail.com'),
            _formEx('CPF', '02171335092'),
            _formEx('Data Nasc', '20/11/1996'),
            FlatButton(
              onPressed: () => null,
              child: Text(
                'Editar',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Color(0xFF583D72),
              //minWidth: 200.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _formEx(String textName, String fieldName) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          //flex: 1,
          child: Text(
            textName,
            style: TextStyle(color: Color(0xFF583D72)),
          ),
        ),
        Expanded(
          flex: 3,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: fieldName,
              hintStyle: TextStyle(
                fontSize: 16,
                color: Color(0xFF000000),
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
      ],
    );
  }
}
