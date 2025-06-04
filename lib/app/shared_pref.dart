

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/model/login_model/login_model.dart';
import '../data/model/users/users_model.dart';
class SharedPref {
  final SharedPreferences prefs;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();




  SharedPref(this.prefs);

  Future<void> setToken(LoginModel model) async {
    await prefs.setString('token', model.token!);
    await prefs.setString('user_name', model.name!);
  }
  Future<void> removeLogin() async {
    await prefs.remove('token',);
    await prefs.remove('user_name');
  }
  Future<String> getToken() async {
  String? token =  await prefs.getString('token',);
  return token??'';

  }
  Future<bool> haveLogin() async {
    String? token = await prefs.getString('token',);
    return token!=null;
  }
  Future <String>getUsername() async {
    String? username = await prefs.getString('user_name',);
    return username??'';
  }
  Future<void> removeUser() async {
    await prefs.remove('token');
    await prefs.remove('user_name');
  }


}