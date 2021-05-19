import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/profile/profile.dart';

class CircularAvatar extends StatelessWidget {
  @override
  final bool isButton;
  final String image;
  const CircularAvatar({@required this.isButton, @required this.image});

  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 42.0,
      child: Material(
        elevation: 4.0,
        shape: CircleBorder(),
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: Ink.image(
            image: AssetImage(image),
            fit: BoxFit.cover,
            width: 120.0,
            height: 120.0,
            child: _isButtonOrNot(context)),
      ),
    );
  }

  Widget _isButtonOrNot(context) {
    if (isButton) {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ProfilePage()));
        },
      );
    } else {
      return null;
    }
  }
}
