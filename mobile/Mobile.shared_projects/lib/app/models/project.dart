import 'dart:convert';

class Projects {
  int id;
  String projectName;
  String description;
  int userAdminId;
  int categoryId;
  String projectType;
  int duration;
  int value;
  List<String> usersProjects;
  List<String> enrolledProjects;

  Projects.fromJson(Map<String, dynamic> map)
      : this.id = map["id"],
        this.projectName = map["projectName"],
        this.description = map["description"],
        this.userAdminId = map["userAdminId"],
        this.categoryId = map["categoryId"],
        this.projectType = map["projectType"],
        this.duration = map["duration"],
        this.value = map["value"],
        this.enrolledProjects = map["enrolledProjects"] != null
            ? map["enrolledProjects"]
                .map<String>((project) => project.toString())
                .toList()
            : null,
        this.usersProjects = map["usersProjects"] != null
            ? map["usersProjects"]
                .map<String>((project) => project.toString())
                .toList()
            : null;

  Map<String, dynamic> pegarProjs() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["projectName"] = this.projectName;
    data["description"] = this.description;
    data["userAdminId"] = this.userAdminId;
    data["categoryId"] = this.categoryId;
    data["enrolledProjects"] = this.enrolledProjects;
    data["usersProjects"] = this.usersProjects;
    data["projectType"] = this.projectType;
    data["duration"] = this.duration;
    data["value"] = this.value;
    return data;
  }

  save() {
    //print("user save");
    // salva user nas preferencias
    Map map = pegarProjs();
    //print("map:$map");
    String jsonEncode = json.encode(map);

    return jsonEncode;
    //print("json save:$json");
  }

  @override
  String toString() {
    return 'Project{ID: $id,Name: $projectName, Descrçao: $description, Users: $usersProjects, Enrolls : $enrolledProjects}';
  }
}
