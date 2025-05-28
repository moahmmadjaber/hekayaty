

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';



import 'dart:ui' as ui;
class SharedPref {
  final SharedPreferences prefs;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();




  SharedPref(this.prefs);



}