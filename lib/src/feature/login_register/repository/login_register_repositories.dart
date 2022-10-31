import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_learning/src/feature/auth/model/user_model.dart';
import 'package:e_learning/src/utils/service/api_provider.dart';
import 'package:e_learning/src/utils/service/custome_exception.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginRegisterRepository {
  ApiProvider apiProvider = ApiProvider();

  String mainUrl = "${dotenv.env['baseUrl']}";

  Future<UserModel> login(
      {required String phone, required String password}) async {
    String url = mainUrl + "login";
    Map body = {"username": phone, "password": password};

    var auth = 'Bearer' + base64Encode(utf8.encode('$phone:$password'));
    print(auth);
    try {
      Response response = await apiProvider.post(
          url, body, Options(headers: <String, String>{'authorization': auth}));
      print(response.statusCode);

      if (response.statusCode == 200 && response.data["code"] == 0) {
        print(response.data);
        return UserModel.fromJson(response.data);
      } else if (response.data["code"].toString() != "0") {
        throw response.data["message"];
      }
      throw CustomException.generalException();
    } catch (error) {
      log(error.toString());
      throw error;
    }
  }

  Future<UserModel> register(
      {required String name,
      required String phoneNumber,
      required String email,
      required String password}) async {
    try {
      String url = mainUrl + "register";
      Map body = {
        "name": name,
        "phone": phoneNumber,
        "password": password,
        "email": email
      };
      print(phoneNumber);
      Response response = await apiProvider.post(url, body, null);
      if (response.statusCode == 200 && response.data["code"] == 0) {
        return UserModel.fromJson(response.data);
      } else if (response.data["code"] != 0) {
        throw response.data["message"];
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}
