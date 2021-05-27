import 'package:flutter/material.dart';

class User {
  final int id;
  final String name;
  final String lastName;
  final String email;
  final String image;

  const User(
      {this.id,
      this.image,
      @required this.name,
      @required this.lastName,
      @required this.email});
}
