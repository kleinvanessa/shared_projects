import 'package:flutter/material.dart';

class User {
  int id;
  String name;
  String lastName;
  String email;

  List<String> userProjects;

  User.fromJson(Map<String, dynamic> map)
      : this.id = map["id"],
        this.name = map["firstName"],
        this.lastName = map["lastName"],
        this.email = map["email"],
        this.userProjects = map["usersProjects"] != null
            ? map["usersProjects"]
                .map<String>((project) => project.toString())
                .toList()
            : null;

  @override
  String toString() {
    return 'User{ID: $id,Name: $name, Latname: $lastName, Login: $email, Projects: $userProjects}';
  }
}
