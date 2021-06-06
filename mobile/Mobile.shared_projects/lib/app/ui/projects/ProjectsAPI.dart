import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:shared_projects/app/models/project.dart';
import 'package:shared_projects/app/models/user.dart';
import 'package:shared_projects/app/models/userProjects.dart';

class ProjectsAPI {
  static Future<List<Projects>> getProjects() async {
    //await Future.delayed(Duration(seconds: 1));
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      print(
          "-------------------------------------------------          GET PROJ          -------------------------------------------------");

      var url = 'https://10.0.2.2:5001/api/project';

      var response = await http.get(
        url,
      );

      List mapResponse = json.decode(response.body);

      final projects = List<Projects>();

      if (response.statusCode == 200) {
        for (Map map in mapResponse) {
          //parser do json de lista
          Projects p = Projects.fromJson(map);
          projects.add(p);
        }

        return projects;
        //final projects = Projects.fromJson(mapResponse);

      }
    } catch (error) {
      print(">>> error:$error");
      throw error;
    }
  }

  static Future<List<Projects>> getProjectsByCategory(int categoryId) async {
    //await Future.delayed(Duration(seconds: 1));
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      print(
          "-------------------------------------------------          GET PROJ By CAT          -------------------------------------------------");
      print("categoryId: $categoryId");
      var url = 'https://10.0.2.2:5001/api/project/Category/$categoryId';
      print("url : $url");
      var response = await http.get(
        url,
      );
      print("response.body:${response.body}");
      List mapResponse = json.decode(response.body);

      final projects = List<Projects>();

      if (response.statusCode == 200) {
        for (Map map in mapResponse) {
          //parser do json de lista
          Projects p = Projects.fromJson(map);
          projects.add(p);
        }
        return projects;
        //final projects = Projects.fromJson(mapResponse);

      }
    } catch (error) {
      print(">>> error:$error");
      throw error;
    }
  }

  static Future<List<Projects>> getProjectsByUser() async {
    //await Future.delayed(Duration(seconds: 1));
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      User user = await User.get();

      int userid = user.id;

      print(
          "-------------------------------------------------          GET PROJ By USER          -------------------------------------------------");
      print("categoryId: $userid");
      var url = 'https://10.0.2.2:5001/api/project/User/$userid';
      print("url : $url");
      var response = await http.get(
        url,
      );
      print("response.body:${response.body}");
      List mapResponse = json.decode(response.body);

      final projects = List<Projects>();

      if (response.statusCode == 200) {
        for (Map map in mapResponse) {
          //parser do json de lista
          Projects p = Projects.fromJson(map);
          projects.add(p);
        }
        print("PROJETOS >>>> $projects");
        return projects;
        //final projects = Projects.fromJson(mapResponse);

      }
    } catch (error) {
      print(">>> error:$error");
      throw error;
    }
  }
}
