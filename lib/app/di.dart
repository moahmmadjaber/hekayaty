

import 'package:get_it/get_it.dart';
import 'package:hekayaty/app/shared_pref.dart';
import 'package:hekayaty/business_logic/login/login_cubit.dart';
import 'package:hekayaty/data/repository/login_repository/login_repository.dart';
import 'package:hekayaty/presentation/login_page/login_page.dart';
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