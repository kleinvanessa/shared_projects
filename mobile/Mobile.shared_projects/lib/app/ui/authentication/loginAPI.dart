import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:shared_projects/app/models/user.dart';
import 'package:shared_projects/app/services/apiResponse.dart';

class LoginAPI {
  static Future<ApiResponse<User>> login(String login, String password) async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      Map data = {
        "email": login,
      };

      Map<String, String> headers = {"Content-Type": "application/json"};

      String body = json.encode(data);

      var url = 'https://10.0.2.2:5001/api/user/Login'; //funfou

      var response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      print('Response status: ${response.statusCode}');

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = User.fromJson(mapResponse);
        return ApiResponse.ok(user);
      }

      return ApiResponse.error(mapResponse["response"]);
    } catch (error, ex) {
      print("Erro no login $error > $ex");
      return ApiResponse.error("Não foi possível fazer o login");
    }
  }
}
