import 'dart:convert';
import 'package:shared_projects/app/utils/prefs.dart';

class Favorite {
  int id;
  int userId;
  int projectId;

  Favorite.fromJson(Map<String, dynamic> map) {
    this.id = map["id"];
    this.userId = map["userId"];
    this.projectId = map["projectId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["userId"] = this.userId;
    data["projectId"] = this.projectId;

    return data;
  }

  @override
  String toString() {
    return 'User{ID: $id,ProjectId: $projectId, userId: $userId}';
  }
}
