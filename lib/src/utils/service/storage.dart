import 'dart:convert';

import 'package:e_learning/src/feature/auth/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  final storage = FlutterSecureStorage();
  Future<void> saveToken({required String token}) async {
    await storage.deleteAll();
    // await storage.write(key: 'name', value: user.name);
    // await storage.write(key: 'phone', value: user.phone);
    await storage.write(key: 'token', value: token);
    // await storage.write(key: 'id', value: user.id);
    // await storage.write(key: 'verifyStatus', value: user.verifyStatus);
  }

  static List<String> convertStringtoListString({required String data}) {
    return json.decode(data);
  }

  Future<String?> getToken() async {
    // String name = await storage.read(key: 'name');
    // String phone = await storage.read(key: 'phone');
    String? token = await storage.read(key: 'token');
    // String id = await storage.read(key: 'id');
    // String verifyStatus = await storage.read(key: 'verifyStatus');
    // if (name != null &&
    //     phone != null &&
    //     token != null &&
    //     id != null &&
    //     verifyStatus != null)
    if (token != null) {
      return token;
    } else
      return null;
  }

  Future<void> saveCurrentUser({required UserModel user}) async {
    await storage.deleteAll();

    await storage.write(key: "roleId", value: user.roleId);

    await storage.write(key: "token", value: user.token);
    await storage.write(key: "id", value: user.id);

    await storage.write(key: "roleName", value: user.roleName);
    // await storage.write(key: "position", value: user.position);

    print(user.roleId);
    print(user.token);
    print(user.roleName);
    // print(user.position);
    print(user.id);

    // await storage.write(key: "type", value: user.type.toString());
    return;
  }

  Future<UserModel?> getCurrentUser() async {
    // String? _id = await storage.read(key: "id");

    String? _roleId = await storage.read(key: "roleId");

    String? _token = await storage.read(key: "token");
    String? _id = await storage.read(key: "id");

    String? _roleName = await storage.read(key: "roleName");
    // String? _position = await storage.read(key: "position");
    print(_roleId);
    print(_token);
    print(_roleName);

    //  String _type = await storage.read(key: "type");

    if ((_roleId != null) &&
        _token != null &&
        _id != null &&
        _roleName != null) {
      return UserModel(
        // position: _position,
        id: _id,
        roleName: _roleName,
        roleId: _roleId,
        token: _token,
      );
    } else {
      return null;
    }
  }

  Future<void> removeToken() async {
    await storage.deleteAll();
    print("delete all token");
    return;
  }

  Future<void> saveSearchHistory({required String history}) async {
    await storage.write(key: "searchHistory", value: history);
    return;
  }

  Future<String?> getSearchHistory() async {
    return await storage.read(key: 'searchHistory');
  }

  Future<void> deleteCurrentUser() async {
    await storage.deleteAll();
    return;
  }
}
