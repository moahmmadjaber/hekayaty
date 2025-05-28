import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hekayaty/business_logic/login/login_cubit.dart';

import '../../app/di.dart';
import '../login_page/login_page.dart';



class Routes{
  static const loginPage='login_page';
}
class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.loginPage:
        initLogin();
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
              create: (_) => instance<LoginCubit>(),
              child: instance<LoginPage>(),
            ));
    default: return MaterialPageRoute(
        settings: settings,
        builder: (context) => Container());

    }


  }}