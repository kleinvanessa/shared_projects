import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:shared_projects/app/model/project.dart';
import 'package:shared_projects/app/model/user.dart';

class ChatAPI {
  static Future<List<User>> chat() async {
    //await Future.delayed(Duration(seconds: 1));
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      print(
          "-------------------------------------------------          GET USER          -------------------------------------------------");

      var url = 'https://10.0.2.2:5001/api/user';

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
}
