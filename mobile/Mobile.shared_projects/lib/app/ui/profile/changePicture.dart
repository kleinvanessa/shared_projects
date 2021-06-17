import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/resources/circleAvatar.dart';

class ChangePicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout.render(
        tittlePage: 'Alterar foto',
        content: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Center(
                child: CircularAvatar(
                  isButton: false,
                  image: 'assets/img/profile.jpg',
                  rad: 100,
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => null),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      'Carregar Imagem',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.upload_outlined,
                      color: Color(0xFF000000),
                    )
                  ],
                ),
                color: Color(0xFFDCDCDC),
                minWidth: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              )
            ],
          ),
        ));
  }
}
