import 'dart:convert';

import 'package:hekayaty/data/model/login_model/login_model.dart';
import 'package:hekayaty/data/network/api.dart';

class LoginRepository {
  Api api;

  LoginRepository(this.api);

  Future<LoginModel> login(String userName, String password) async {
    try {
      final body={
        "user_name": userName.toString(),
        "password": password.toString()
      };
      final res = await api.callNoTokenApi(
        body,
        '/V1/api/auth/login',
        sendToken: false,
      );
      print(res);
      return LoginModel.fromJson(jsonDecode(res));
    } catch (ex) {
      print(ex.toString());
      rethrow;
    }
  }
}
