import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class LoginAPI {
  static Future<bool> login(String login, String password) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    Map data = {
      "firstname": password,
      "email": login,
    };

    Map<String, String> headers = {"Content-Type": "application/json"};

    String body = json.encode(data);
    print(">>>>>>>> $body");
    var url = 'https://10.0.2.2:5001/api/user'; //funfou
    //); //''); //

    var response = await http.post(
      url,
      //'https://10.0.2.2:44380/api/user',
      headers: headers,
      body: body,
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return true;
  }
}
