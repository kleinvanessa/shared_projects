import 'package:flutter/material.dart';

class FlatButtonComponent extends StatelessWidget {
  // @override
  final routeButton;
  final String textButton;
  final buttonColor;
  final Function onPressed;

  const FlatButtonComponent(
      {@required this.routeButton,
      @required this.textButton,
      @required this.buttonColor,
      @required this.onPressed});

  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      /*() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => routeButton),
        );
      },*/
      child: Text(
        textButton,
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.bold,
        ),
      ),
      color: buttonColor,
      minWidth: 200.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }
}
