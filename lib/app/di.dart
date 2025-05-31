

import 'package:get_it/get_it.dart';
import 'package:hekayaty/app/shared_pref.dart';
import 'package:hekayaty/business_logic/home/home_cubit.dart';
import 'package:hekayaty/business_logic/login/login_cubit.dart';
import 'package:hekayaty/business_logic/school_supply/school_supply_cubit.dart';
import 'package:hekayaty/business_logic/tickets/tickets_cubit.dart';
import 'package:hekayaty/data/repository/home/home_repository.dart';
import 'package:hekayaty/data/repository/login_repository/login_repository.dart';
import 'package:hekayaty/data/repository/school_supply/school_supply.dart';
import 'package:hekayaty/data/repository/tickets/tickets_repository.dart';
import 'package:hekayaty/presentation/home_page/home_page.dart';
import 'package:hekayaty/presentation/login_page/login_page.dart';
import 'package:hekayaty/presentation/school_suply/school_suply.dart';
import 'package:hekayaty/presentation/tickets_page/tickets_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/network/api.dart';
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
    } catch (ex) {}
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
Future<void> initTickets() async {
  try {
    if (!GetIt.I.isRegistered<TicketsCubit>()) {
      instance.registerFactory<TicketsCubit>(() => TicketsCubit(instance()));
      instance.registerLazySingleton<TicketsRepository>(() => TicketsRepository(instance()));
      instance.registerLazySingleton<TicketsPage>(() => TicketsPage());
    }
  } catch (ex) {}
}
Future<void> initSchoolSupply() async {
  try {
    if (!GetIt.I.isRegistered<SchoolSupplyCubit>()) {
      instance.registerFactory<SchoolSupplyCubit>(() => SchoolSupplyCubit(instance()));
      instance.registerLazySingleton<SchoolSupplyRepository>(() => SchoolSupplyRepository(instance()));
      instance.registerLazySingleton<SchoolSupply>(() => SchoolSupply());
    }
  } catch (ex) {}
}