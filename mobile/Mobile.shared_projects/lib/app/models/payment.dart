import 'dart:convert';
import 'package:shared_projects/app/utils/prefs.dart';

class Payment {
  int id;
  int userId;
  String bank;
  int agency;
  int account;

  Payment.fromJson(Map<String, dynamic> map) {
    this.id = map["id"];
    this.userId = map["userId"];
    this.bank = map["bank"];
    this.agency = map["agency"];
    this.account = map["account"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["userId"] = this.userId;
    data["bank"] = this.bank;
    data["agency"] = this.agency;
    data["account"] = this.account;
    return data;
  }

  static void clear() {
    Prefs.setString("payment.prefs", "");
  }

  void save() {
    //print("user save");
    // salva user nas preferencias
    Map map = toJson();
    //print("map:$map");
    String jsonEncode = json.encode(map);
    //print("json save:$json");
    Prefs.setString("payment.prefs", jsonEncode);
  }

  static Future<Payment> get() async {
    // print("user get");
    String jsonDecode = await Prefs.getString("payment.prefs");
    if (jsonDecode.isEmpty) {
      return null;
    }
    print("json:$json");
    Map map = json.decode(jsonDecode);
    Payment payment = Payment.fromJson(map);
    // print("user no get:$user");
    return payment;
  }

  @override
  String toString() {
    return 'Payment{ID: $id,UserId: $userId, bank: $bank, agency: $agency, account: $account}';
  }
}
