import 'package:flutter/material.dart';
import 'package:hekayaty/presentation/app_resources/color_manager.dart';

import '../presentation/app_resources/route_manger.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar", "IQ"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: Locale("ar", "IQ"), // OR
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'dinn',

        colorScheme: ColorScheme.fromSeed(seedColor: MyColor.colorPrimary),
      ),onGenerateRoute: RouteGenerator.getRoute,initialRoute: Routes.loginPage,
    );
  }
}

class GlobalCupertinoLocalizations {
}