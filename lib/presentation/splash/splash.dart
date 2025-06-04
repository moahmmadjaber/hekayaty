import 'package:flutter/material.dart';
import 'package:hekayaty/app/shared_pref.dart';


import '../../app/di.dart';
import '../app_resources/route_manger.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  bool haveLogin = false;
  double op = 1;

  // _startDelay() {
  //   _timer = Timer(const Duration(milliseconds: 3000), _goNext);
  // }
  //
  // void _goNext() async {
  //
  //     if (!mounted) return;
  //     Navigator.pushNamedAndRemoveUntil(
  //         context, Routes.homeRoute, (route) => false);
  //
  // }

  @override
  void initState() {
    checkLogin();
    initHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: op,
      duration: Duration(milliseconds: 500),
      child: Center(
        child: Image.asset(
          'assets/images/hakayety_title.png',
          width: MediaQuery.of(context).size.width * 0.8,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void checkLogin() async {
    Future.delayed(Duration(milliseconds: 3000), () {
      setState(() {
        op = 0;
      });
    });
    haveLogin = await instance<SharedPref>().haveLogin();
    Future.delayed(Duration(milliseconds: 3500), () {
      if (haveLogin) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.homePage,
          (route) => false,
        );
      }else{
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.loginPage,
              (route) => false,
        );
      }

    });
  }
}
