class Projects {
  int id;
  String projectName;
  String description;
  List<String> usersProjects;

  Projects.fromJson(Map<String, dynamic> map)
      : this.id = map["id"],
        this.projectName = map["projectName"],
        this.description = map["description"],
        this.usersProjects = map["usersProjects"] != null
            ? map["usersProjects"]
                .map<String>((project) => project.toString())
                .toList()
            : null;

  @override
  String toString() {
    return 'Project{ID: $id,Name: $projectName, Descrçao: $description, Users: $usersProjects}';
  }
}
