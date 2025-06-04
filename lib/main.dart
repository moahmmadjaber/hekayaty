import 'package:flutter/material.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'app/app.dart';
import 'app/di.dart';

Future<void> main() async {
  tz.initializeTimeZones();

  // Set the local timezone to Iraq (Asia/Baghdad)
  tz.setLocalLocation(tz.getLocation('Asia/Baghdad'));
  WidgetsFlutterBinding.ensureInitialized();
 await  initAppModule();
  runApp(const MyApp());
}



