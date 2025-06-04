

import 'package:get_it/get_it.dart';
import 'package:hekayaty/app/shared_pref.dart';
import 'package:hekayaty/business_logic/cafeteria/cafeteria_cubit.dart';
import 'package:hekayaty/business_logic/history/history_cubit.dart';
import 'package:hekayaty/business_logic/home/home_cubit.dart';
import 'package:hekayaty/business_logic/login/login_cubit.dart';
import 'package:hekayaty/business_logic/school_supply/school_supply_cubit.dart';
import 'package:hekayaty/business_logic/tickets/tickets_cubit.dart';
import 'package:hekayaty/data/model/categories_model/categories_model.dart';
import 'package:hekayaty/data/repository/cafeteria/cafeteria_repository.dart';
import 'package:hekayaty/data/repository/history/history_repository.dart';
import 'package:hekayaty/data/repository/home/home_repository.dart';
import 'package:hekayaty/data/repository/login_repository/login_repository.dart';
import 'package:hekayaty/data/repository/school_supply/school_supply.dart';
import 'package:hekayaty/data/repository/swimming_pool/swimming_pool_repository.dart';
import 'package:hekayaty/data/repository/tickets/tickets_repository.dart';
import 'package:hekayaty/presentation/cafeteria/cafeteria_page.dart';
import 'package:hekayaty/presentation/history/history_page.dart';
import 'package:hekayaty/presentation/home_page/home_page.dart';
import 'package:hekayaty/presentation/login_page/login_page.dart';
import 'package:hekayaty/presentation/school_suply/school_suply.dart';
import 'package:hekayaty/presentation/tickets_page/tickets_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../business_logic/restaurant/restaurant_cubit.dart';
import '../business_logic/swimming_pool/swimming_pool_cubit.dart';
import '../data/network/api.dart';
import '../data/repository/restaurant/restaurant_repository.dart';
import '../presentation/restaurant_page/restaurant_page.dart';
import '../presentation/swimming_pool_page/swimming_pool_page.dart';
import 'app.dart';

bool darkTheme = false;
bool isLeft = false;
bool sendNotification = true;
const double btnHeight = 50;
final instance = GetIt.instance;
int userType = 0;
bool notificationPermission = true;
List<String> allUsers = [];
int userId = 0;

@pragma('vm:entry-point')
Future<void> initAppModule() async {
  try {
    final sharedPrefs = await SharedPreferences.getInstance();
    instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
    instance.registerLazySingleton<SharedPref>(() => SharedPref(instance()));
    instance.registerLazySingleton<Api>(() => Api(
      instance(),
    ));
    instance.registerFactory<MyApp>(() => MyApp());
    try {
initLogin();    } catch (ex) {}
  } catch (ex) {
    print(ex.toString());
  }
}

@pragma('vm:entry-point')
Future<void> initShared() async {
  try {
    if (!GetIt.I.isRegistered<SharedPreferences>()) {
      final sharedPrefs = await SharedPreferences.getInstance();
      instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
      instance.registerLazySingleton<SharedPref>(() => SharedPref(instance()));
    }
  } catch (ex) {}
}
Future<void> initLogin() async {
  try {
    if (!GetIt.I.isRegistered<LoginCubit>()) {
      instance.registerFactory<LoginCubit>(() => LoginCubit(instance()));
      instance.registerLazySingleton<LoginRepository>(() => LoginRepository(instance()));
      instance.registerLazySingleton<LoginPage>(() => LoginPage());
    }
  } catch (ex) {}
}
Future<void> initHome() async {
  try {
    if (!GetIt.I.isRegistered<HomeCubit>()) {
      instance.registerFactory<HomeCubit>(() => HomeCubit(instance()));
      instance.registerLazySingleton<HomeRepository>(() => HomeRepository(instance()));
      instance.registerLazySingleton<MyHomePage>(() => MyHomePage());
    }
  } catch (ex) {}
}
Future<void> initHistory() async {
  try {
    if (!GetIt.I.isRegistered<HistoryCubit>()) {
      instance.registerFactory<HistoryCubit>(() => HistoryCubit(instance()));
      instance.registerLazySingleton<HistoryRepository>(() => HistoryRepository(instance()));
      instance.registerLazySingleton<HistoryPage>(() => HistoryPage());
    }
  } catch (ex) {}
}
Future<void> initTickets() async {
  try {
    if (!GetIt.I.isRegistered<TicketsCubit>()) {
      instance.registerFactory<TicketsCubit>(() => TicketsCubit(instance()));
      instance.registerLazySingleton<TicketsRepository>(() => TicketsRepository(instance()));
    }
  } catch (ex) {}
}
Future<void> initSchoolSupply() async {
  try {
    if (!GetIt.I.isRegistered<SchoolSupplyCubit>()) {
      instance.registerFactory<SchoolSupplyCubit>(() => SchoolSupplyCubit(instance()));
      instance.registerLazySingleton<SchoolSupplyRepository>(() => SchoolSupplyRepository(instance()));
    }
  } catch (ex) {}
}

Future<void> initCafeteria() async {
  try {
    if (!GetIt.I.isRegistered<CafeteriaCubit>()) {
      instance.registerFactory<CafeteriaCubit>(() => CafeteriaCubit(instance()));
      instance.registerLazySingleton<CafeteriaRepository>(() => CafeteriaRepository(instance()));
    }
  } catch (ex) {}
}
Future<void> initRestaurant() async {
  try {
    if (!GetIt.I.isRegistered<RestaurantCubit>()) {
      instance.registerFactory<RestaurantCubit>(() => RestaurantCubit(instance()));
      instance.registerLazySingleton<RestaurantRepository>(() => RestaurantRepository(instance()));

    }
  } catch (ex) {}
}
Future<void> initSwimmingPool() async {
  try {
    if (!GetIt.I.isRegistered<SwimmingPoolCubit>()) {
      instance.registerFactory<SwimmingPoolCubit>(() => SwimmingPoolCubit(instance()));
      instance.registerLazySingleton<SwimmingPoolRepository>(() => SwimmingPoolRepository(instance()));

    }
  } catch (ex) {}
}