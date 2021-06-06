class UserProjects {
  int userId;
  int projectId;
  List<String> project;

  UserProjects({this.userId, this.projectId, this.project});

  UserProjects.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];

    projectId = json['projectId'];
    this.project = json["usersProjects"] != null
        ? json["usersProjects"]
            .map<String>((project) => project.toString())
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;

    data['projectId'] = this.projectId;

    data["project"] = this.project;

    return data;
  }
}
