import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:shared_projects/app/models/curriculum.dart';
import 'package:shared_projects/app/models/payment.dart';
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
        "password": password,
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
        user.save();

        User user2 = await User.get();
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>   user2:$user2");

        return ApiResponse.ok(user);
      }

      return ApiResponse.error(mapResponse["response"]);
    } catch (error, ex) {
      print("Erro no login $error > $ex");
      //throw error;
      return ApiResponse.error("Não foi possível fazer o login");
    }
  }

  static Future<ApiResponse<Curriculum>> getCurriculum() async {
    //await Future.delayed(Duration(seconds: 1));
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      User user = await User.get();

      int userId;

      userId = user.id;
      print("useriD: $userId");

      print(
          "-------------------------------------------------          GET Curriculum          -------------------------------------------------");

      var url = 'https://10.0.2.2:5001/api/user/getCurriculum/$userId';

      var response = await http.get(
        url,
      );

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final curriculum = Curriculum.fromJson(mapResponse);
        curriculum.save();

        return ApiResponse.ok(curriculum);
      }
      return ApiResponse.error(mapResponse["response"]);
    } catch (error) {
      print(">>> error:$error");
      return ApiResponse.error("Não foi possível pegaer o curriculo");
    }
  }

  static Future<Curriculum> getCurriculumUser(int id) async {
    //await Future.delayed(Duration(seconds: 1));
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      User user = await User.get();

      int userId;
      print("ID: $id");
      userId = id;
      print("useriD: $userId");

      print(
          "-------------------------------------------------          GET Curriculum   USER       -------------------------------------------------");

      var url = 'https://10.0.2.2:5001/api/user/getCurriculum/$userId';

      var response = await http.get(
        url,
      );

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final curriculum = Curriculum.fromJson(mapResponse);

        return curriculum;
      }
      //return ApiResponse.error(mapResponse["response"]);
    } catch (error) {
      print(">>> error:$error");
      throw error;
      //return ApiResponse.error("Não foi possível pegaer o curriculo");
    }
  }

  static Future<ApiResponse<Payment>> getPayment() async {
    //await Future.delayed(Duration(seconds: 1));
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      User user = await User.get();
      int userId = user.id;

      print(
          "-------------------------------------------------          GET Payment          -------------------------------------------------");

      var url = 'https://10.0.2.2:5001/api/user/getPayment/$userId';

      var response = await http.get(
        url,
      );

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final payment = Payment.fromJson(mapResponse);
        payment.save();

        return ApiResponse.ok(payment);
      }
      return ApiResponse.error(mapResponse["response"]);
    } catch (error) {
      print(">>> error:$error");
      return ApiResponse.error("Não foi possível pegar o payment");
    }
  }
}
