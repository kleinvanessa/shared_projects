import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class RegisterAPI {
  static Future<bool> register(
      String firstName, String lastName, String email) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    Map data = {
      "firstname": firstName,
      "lastname": lastName,
      "email": email,
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

    if (response.body == "email dif de null, email ja existe") {
      return false;
    }

    return true;
  }
}
