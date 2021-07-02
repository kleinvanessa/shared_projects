import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:shared_projects/app/models/project.dart';
import 'package:shared_projects/app/models/user.dart';
import 'package:shared_projects/app/models/userProjects.dart';
import 'package:shared_projects/app/services/apiResponse.dart';

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
      // print("response.body:${response.body}");
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

  static Future<List<Projects>> getProjectsByUserEnroll() async {
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
      var url = 'https://10.0.2.2:5001/api/project/getEnroll/$userid';
      print("url : $url");
      var response = await http.get(
        url,
      );
      // print("response.body:${response.body}");
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

  static Future<ApiResponse<Projects>> enroolProject(
    int projectId,
    String projName,
    String projDesc,
    int userAdminId,
    int categoryId,
  ) async {
    //await Future.delayed(Duration(seconds: 1));
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      User user = await User.get();

      int userid = user.id;

      var enrollProject =
          '{"id": "$projectId","projectName": "$projName","description": "$projDesc","userAdminId": "$userAdminId","categoryId": "$categoryId","enrolledProjects":[{"userid": "$userid"}] }';
      Map<String, String> headers = {"Content-Type": "application/json"};

      print(
          "-------------------------------------------------          ENROLL PROJ         -------------------------------------------------");

      var url = 'https://10.0.2.2:5001/api/project/enroll/$projectId';

      var response = await http.put(
        url,
        headers: headers,
        body: enrollProject,
      );
      // print("response.body:${response.body}");
      print('Response status: ${response.statusCode}');

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        // final project = Projects.fromJson(mapResponse);
        return ApiResponse.postOk(mapResponse["response"]);
      }

      return ApiResponse.error(mapResponse["response"]);
    } catch (error) {
      print(">>> error:$error");
      throw error;
    }
  }

  static Future<List<User>> usersEnrolls(int projectId) async {
    //await Future.delayed(Duration(seconds: 1));
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      print(
          "-------------------------------------------------          GET USER          -------------------------------------------------");

      var url = 'https://10.0.2.2:5001/api/project/getEnrollUsers/$projectId';

      var response = await http.get(
        url,
      );
      List mapResponse = json.decode(response.body);

      final users = mapResponse
          .map<User>((map) => User.fromJson(map))
          .toList(); //parse de JSON de uma lista

      if (response.statusCode == 200) {
        return users;
      }
    } catch (error) {
      print(">>> error:$error");
    }
  }

  static Future<ApiResponse<Projects>> deleteProject(int projectId) async {
    //await Future.delayed(Duration(seconds: 1));
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      print(
          "-------------------------------------------------          DELETE PROJETO          -------------------------------------------------");

      var url = 'https://10.0.2.2:5001/api/project/$projectId';

      var response = await http.delete(
        url,
      );
      if (response.statusCode == 200) {
        print("delete ok");
        return ApiResponse.deleteOk(response.body);
      }
    } catch (error) {
      print(">>> error:$error");
    }
  }
}
