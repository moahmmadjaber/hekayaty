import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hekayaty/business_logic/history/history_cubit.dart';
import 'package:hekayaty/business_logic/home/home_cubit.dart';
import 'package:hekayaty/business_logic/login/login_cubit.dart';
import 'package:hekayaty/business_logic/restaurant/restaurant_cubit.dart';
import 'package:hekayaty/business_logic/school_supply/school_supply_cubit.dart';
import 'package:hekayaty/business_logic/swimming_pool/swimming_pool_cubit.dart';
import 'package:hekayaty/business_logic/tickets/tickets_cubit.dart';
import 'package:hekayaty/data/model/categories_model/categories_model.dart';
import 'package:hekayaty/presentation/cafeteria/cafeteria_page.dart';
import 'package:hekayaty/presentation/history/history_page.dart';
import 'package:hekayaty/presentation/restaurant_page/restaurant_page.dart';
import 'package:hekayaty/presentation/splash/splash.dart';
import 'package:hekayaty/presentation/swimming_pool_page/swimming_pool_page.dart';

import '../../app/di.dart';
import '../../business_logic/cafeteria/cafeteria_cubit.dart';
import '../home_page/home_page.dart';
import '../login_page/login_page.dart';
import '../school_suply/school_suply.dart';
import '../tickets_page/tickets_page.dart';



class Routes{
  static const splash='/splash';
  static const loginPage='/login_page';
  static const homePage='/home_page';
  static const ticketsPage='/tickets_page';
  static const schoolSupply='/school_supply';
  static const cafeteria='/cafeteria';
  static const restaurant='/restaurant';
  static const swimmingPool='/swimming_pool';
  static const history='/history';
}
class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.splash:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => Splash());
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
      case Routes.history:

        initHistory();
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
              create: (_) => instance<HistoryCubit>(),
              child: instance<HistoryPage>(),
            ));

      case Routes.ticketsPage:
        var item=settings.arguments as CategoriesModel;
        initTickets();
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
              create: (_) => instance<TicketsCubit>(),
              child:TicketsPage(item: item,)
            ));
      case Routes.schoolSupply:
        var item=settings.arguments as CategoriesModel;
        initSchoolSupply();
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
              create: (_) => instance<SchoolSupplyCubit>(),
              child:SchoolSupply(item: item,),
            ));
      case Routes.cafeteria:

        var item=settings.arguments as CategoriesModel;
        initCafeteria();
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
              create: (_) => instance<CafeteriaCubit>(),
              child: CafeteriaPage(item: item,),
            ));
      case Routes.restaurant:
        var item=settings.arguments as CategoriesModel;
        initRestaurant();
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
              create: (_) => instance<RestaurantCubit>(),
              child: RestaurantPage(item: item,),
            ));

      case Routes.swimmingPool:
        var item=settings.arguments as CategoriesModel;
        initSwimmingPool();
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
              create: (_) => instance<SwimmingPoolCubit>(),
              child:SwimmingPoolPage(item: item,),
            ));
    default: return MaterialPageRoute(
        settings: settings,
        builder: (context) => Container());

    }


  }}