import 'dart:convert';
import 'package:shared_projects/app/utils/prefs.dart';

class Curriculum {
  int id;
  int userId;
  String institution;
  String course;
  String activites;

  List<String> userProjects;

  Curriculum.fromJson(Map<String, dynamic> map) {
    this.id = map["id"];
    this.userId = map["userId"];
    this.institution = map["institution"];
    this.course = map["course"];
    this.activites = map["activites"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["userId"] = this.userId;
    data["institution"] = this.institution;
    data["course"] = this.course;
    data["activites"] = this.activites;
    return data;
  }

  static void clear() {
    Prefs.setString("curriculum.prefs", "");
  }

  void save() {
    //print("user save");
    // salva user nas preferencias
    Map map = toJson();
    //print("map:$map");
    String jsonEncode = json.encode(map);
    //print("json save:$json");
    Prefs.setString("curriculum.prefs", jsonEncode);
  }

  static Future<Curriculum> get() async {
    // print("user get");
    String jsonDecode = await Prefs.getString("curriculum.prefs");
    if (jsonDecode.isEmpty) {
      return null;
    }
    print("json:$json");
    Map map = json.decode(jsonDecode);
    Curriculum user = Curriculum.fromJson(map);
    // print("user no get:$user");
    return user;
  }

  @override
  String toString() {
    return 'User{ID: $id,UserId: $userId, Inst: $institution, Course: $course, Activites: $activites}';
  }
}
