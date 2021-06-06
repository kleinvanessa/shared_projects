import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:shared_projects/app/models/project.dart';
import 'package:shared_projects/app/models/user.dart';
import 'package:shared_projects/app/services/apiResponse.dart';

class AddNewProjectAPI {
  static Future<ApiResponse<Projects>> addProject(
      String projectName, String description, String category) async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      User user = await User.get();

      int userid = user.id;

      var userProject =
          '{"projectName": "$projectName", "description": "$description", "categoryId": "$category","usersProjects":[{"userid": "$userid"}] }'; //[{"userid" : "$userid"}]}';

      print(">>>>> teste:  $userProject");

      Map data = {
        "projectName": projectName,
        "description": description,
        "categoryId": category,
      };

      print(" >>>>>  projeto a ser adicionado: $data");

      Map<String, String> headers = {"Content-Type": "application/json"};

      String body = json.encode(data);

      print(">>>>>>> body: $body");

      var url = 'https://10.0.2.2:5001/api/project'; //funfou

      var response = await http.post(
        url,
        headers: headers,
        body: userProject,
      );
      print('Response status: ${response.statusCode}');

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        // final project = Projects.fromJson(mapResponse);
        return ApiResponse.postOk(mapResponse["response"]);
      }

      return ApiResponse.error(mapResponse["response"]);
    } catch (error, ex) {
      print("Erro ao cadastrar projeto $error > $ex");
      return ApiResponse.error("Não foi possível fazer o cadastro do projeto");
    }
  }
}
