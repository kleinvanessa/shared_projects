import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:shared_projects/app/models/curriculum.dart';
import 'package:shared_projects/app/models/payment.dart';
import 'package:shared_projects/app/models/user.dart';
import 'package:shared_projects/app/models/userProjects.dart';
import 'package:shared_projects/app/services/apiResponse.dart';

class ProfileUpdateAPI {
  static Future<User> getUserById(int id) async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      print(
          "-------------------------------------------------          GET USER BY ID          -------------------------------------------------");

      var url = 'https://10.0.2.2:5001/api/user/$id';

      var response = await http.get(
        url,
      );
      print('Response status: ${response.statusCode}');

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = User.fromJson(mapResponse);
        return user;
      }
    } catch (error, ex) {
      print("Erro ao atualizar dados $error > $ex");
      //throw error;

    } //usersProj/{id}
  }

  static Future<List<User>> usersInProj(int projectId) async {
    //await Future.delayed(Duration(seconds: 1));
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      print(
          "-------------------------------------------------          GET USERs in Proj          -------------------------------------------------");

      var url = 'https://10.0.2.2:5001/api/user/getUsersSubProjects/$projectId';

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

  static Future<List<UserProjects>> getUserProjByProjId(int id) async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      print(
          "-------------------------------------------------          GET USER PROJ BY PROJID          -------------------------------------------------");

      var url = 'https://10.0.2.2:5001/api/user/usersProj/$id';

      var response = await http.get(
        url,
      );
      print('Response status: ${response.statusCode}');

      List mapResponse = json.decode(response.body);

      final userP = List<UserProjects>();

      if (response.statusCode == 200) {
        for (Map map in mapResponse) {
          //parser do json de lista
          UserProjects p = UserProjects.fromJson(map);
          userP.add(p);
        }

        return userP;
      }
    } catch (error, ex) {
      print("Erro ao atualizar dados $error > $ex");
      throw error;
    }

    ///{id}
  }

  static Future<ApiResponse<User>> updateUser(
      String firstName, String lastName, String email, String contact) async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      User user = await User.get();

      int userid = user.id;

      Map data = {
        "id": userid,
        "firstname": firstName,
        "lastname": lastName,
        "email": email,
        "contact": contact,
        "password": user.password
      };
      print("AQUI OS DADOS : >>>>>>>>>> $data");
      Map<String, String> headers = {"Content-Type": "application/json"};

      String body = json.encode(data);

      var url = 'https://10.0.2.2:5001/api/user/$userid'; //funfou

      var response = await http.put(
        url,
        headers: headers,
        body: body,
      );
      print('Response status: ${response.statusCode}');

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = User.fromJson(mapResponse);
        user.save();
        return ApiResponse.ok(user);
      }

      return ApiResponse.error(mapResponse["response"]);
    } catch (error, ex) {
      print("Erro ao atualizar dados $error > $ex");
      //throw error;
      return ApiResponse.error("Não foi possível atualizar os dados");
    }
  }

  static Future<ApiResponse<Curriculum>> updateUserCurriculum(
      String institution, String course, String activites,
      {int id = 0}) async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      User user = await User.get();

      Curriculum curriculum = await Curriculum.get();

      curriculum != null ? id = curriculum.id : id = 0;

      print("===== ====== ===== > curriculumId : $id");

      int userid = user.id;

      Map data = {
        "id": id,
        "userId": userid,
        "institution": institution,
        "course": course,
        "activites": activites,
      };

      print("AQUI OS DADOS DO CURRICULUM : >>>>>>>>>> $data");
      Map<String, String> headers = {"Content-Type": "application/json"};

      String body = json.encode(data);

      var url = 'https://10.0.2.2:5001/api/user/upsertCurriculum'; //funfou

      var response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      print('Response status: ${response.statusCode}');

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final curriculum = Curriculum.fromJson(mapResponse);
        curriculum.save();
        return ApiResponse.ok(curriculum);
      }

      return ApiResponse.error(mapResponse["response"]);
    } catch (error, ex) {
      print("Erro ao atualizar dados $error > $ex");
      //throw error;
      return ApiResponse.error("Não foi possível atualizar os dados");
    }
  }

  static Future<ApiResponse<Payment>> updateUserPayment(
      String bank, String agency, String account,
      {int id = 0}) async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      User user = await User.get();

      Payment payment = await Payment.get();

      payment != null ? id = payment.id : id = 0;

      print("===== ====== ===== > PaymentId : $id");

      int userid = user.id;

      Map data = {
        "id": id,
        "userId": userid,
        "bank": bank,
        "agency": agency,
        "account": account,
      };

      print("AQUI OS DADOS DO Payment : >>>>>>>>>> $data");
      Map<String, String> headers = {"Content-Type": "application/json"};

      String body = json.encode(data);

      var url = 'https://10.0.2.2:5001/api/user/upsertPayment'; //funfou

      var response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      print('Response status: ${response.statusCode}');

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final payment = Payment.fromJson(mapResponse);
        payment.save();
        return ApiResponse.ok(payment);
      }

      return ApiResponse.error(mapResponse["response"]);
    } catch (error, ex) {
      print("Erro ao atualizar dados $error > $ex");
      //throw error;
      return ApiResponse.error("Não foi possível atualizar os dados");
    }
  }
}
