import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Alert(BuildContext context, String msg, String title,
    {bool secondButton = false}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text(title),
            content: Text(msg),
            actions: <Widget>[
              /* FlatButton(
                child: Text("cancelar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),*/
              FlatButton(
                child: Text("ok"),
                onPressed: () {
                  Navigator.pop(context);
                  //print("OK!!!!!!!!");
                },
              ),
              secondButton
                  ? FlatButton(
                      child: Text("Não"),
                      onPressed: () {
                        Navigator.pop(context);
                        //print("OK!!!!!!!!");
                      },
                    )
                  : Container()
            ],
          ),
        );
      });
}
