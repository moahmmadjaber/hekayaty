import 'package:flutter/cupertino.dart';
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
        // CupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar", "SA"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: Locale("ar", "SA"), // OR
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'dinn',scaffoldBackgroundColor: MyColor.lowGray,appBarTheme: AppBarTheme(centerTitle: true,iconTheme: IconThemeData(color: MyColor.colorWhite),backgroundColor: MyColor.colorPrimary),

        colorScheme: ColorScheme.fromSeed(seedColor: MyColor.colorPrimary),
      ),onGenerateRoute: RouteGenerator.getRoute,initialRoute: Routes.loginPage,
    );
  }
}
