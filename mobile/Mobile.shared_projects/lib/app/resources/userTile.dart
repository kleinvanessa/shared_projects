import 'package:flutter/material.dart';
import 'circleAvatar.dart';
import 'package:shared_projects/app/models/user.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = CircularAvatar(isButton: false, image: user.image);
    return ListTile(
      leading: avatar,
      title: Row(
        children: [
          Text(user.name),
          SizedBox(
            width: 5,
          ),
          Text(user.lastName)
        ],
      ),
      subtitle: Text(user.email),
    );
  }
}
