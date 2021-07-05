class UserProjects {
  int userId;
  int projectId;

  UserProjects({this.userId, this.projectId});

  UserProjects.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    projectId = json['projectId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;

    data['projectId'] = this.projectId;

    return data;
  }
}
