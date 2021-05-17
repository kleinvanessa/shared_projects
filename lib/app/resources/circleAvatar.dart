import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/profile/profile.dart';
//import 'package:flutter_modular/flutter_modular.dart';

class CircularAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      //backgroundImage: AssetImage('assets/img/profile.jpg'),
      backgroundColor: Colors.white,
      radius: 42.0,
      child: Material(
        child: _typeOfCircleAvatar(context),
        shape: CircleBorder(),
      ),
    );
  }

  Widget _typeOfCircleAvatar(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ProfilePage()));
      },
    );
  }
}
//AssetImage('assets/img/profile.jpg'),
