import 'dart:convert';
import 'package:shared_projects/app/utils/prefs.dart';

class User {
  int id;
  String name;
  String lastName;
  String email;
  int contact;
  String password;

  List<String> userProjects;

  User.fromJson(Map<String, dynamic> map) {
    this.id = map["id"];
    this.name = map["firstName"];
    this.lastName = map["lastName"];
    this.email = map["email"];
    this.contact = map["contact"];
    this.password = map["password"];
    this.userProjects = map["usersProjects"] != null
        ? map["usersProjects"]
            .map<String>((project) => project.toString())
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["firstName"] = this.name;
    data["lastName"] = this.lastName;
    data["email"] = this.email;
    data["contact"] = this.contact;
    data["password"] = this.password;
    data["usersProjects"] = this.userProjects;
    return data;
  }

  static void clear() {
    Prefs.setString("user.prefs", "");
  }

  void save() {
    print("user save");
    // salva user nas preferencias
    Map map = toJson();
    print("map:$map");
    String jsonEncode = json.encode(map);
    print("json save:$json");
    Prefs.setString("user.prefs", jsonEncode);
  }

  static Future<User> get() async {
    print("user get");
    String jsonDecode = await Prefs.getString("user.prefs");
    if (jsonDecode.isEmpty) {
      return null;
    }
    print("json:$json");
    Map map = json.decode(jsonDecode);
    User user = User.fromJson(map);
    print("user no get:$user");
    return user;
  }

  @override
  String toString() {
    return 'User{ID: $id,Name: $name, Latname: $lastName, Login: $email, Senha: $password Projects: $userProjects}';
  }
}
