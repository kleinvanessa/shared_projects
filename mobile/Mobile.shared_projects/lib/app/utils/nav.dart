import 'package:flutter/material.dart';

Future push(BuildContext context, Widget page, {bool replace = false}) {
  return replace //replace serve para tirar o botao de voltar da page
      ? Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
          return page;
        }))
      : Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
          return page;
        }));
}
