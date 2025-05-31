import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hekayaty/business_logic/home/home_cubit.dart';
import 'package:hekayaty/business_logic/login/login_cubit.dart';
import 'package:hekayaty/business_logic/school_supply/school_supply_cubit.dart';
import 'package:hekayaty/business_logic/tickets/tickets_cubit.dart';

import '../../app/di.dart';
import '../home_page/home_page.dart';
import '../login_page/login_page.dart';
import '../school_suply/school_suply.dart';
import '../tickets_page/tickets_page.dart';



class Routes{
  static const loginPage='login_page';
  static const homePage='home_page';
  static const ticketsPage='tickets_page';
  static const schoolSupply='school_supply';
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
      case Routes.homePage:
        initHome();
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
              create: (_) => instance<HomeCubit>(),
              child: instance<MyHomePage>(),
            ));
      case Routes.ticketsPage:
        initTickets();
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
              create: (_) => instance<TicketsCubit>(),
              child: instance<TicketsPage>(),
            ));
      case Routes.schoolSupply:
        initSchoolSupply();
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
              create: (_) => instance<SchoolSupplyCubit>(),
              child: instance<SchoolSupply>(),
            ));

    default: return MaterialPageRoute(
        settings: settings,
        builder: (context) => Container());

    }


  }}