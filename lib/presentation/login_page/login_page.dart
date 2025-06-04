import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:hekayaty/app/di.dart';
import 'package:hekayaty/app/shared_pref.dart';
import 'package:hekayaty/business_logic/login/login_cubit.dart';
import 'package:hekayaty/presentation/app_resources/color_manager.dart';
import 'package:hekayaty/presentation/app_resources/enum_manager.dart';
import 'package:hekayaty/presentation/widgits/my_constant.dart';

import '../app_resources/route_manger.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _message = '';
  late LoginCubit bloc;
@override
  void initState() {
    bloc=BlocProvider.of<LoginCubit>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit,LoginState>(listener: (context,state) async {
      if(state is LoginLoading){
        showToast('جاري التحميل', ToastType.load);
      }
      if(state is LoginComplete){
        EasyLoading.dismiss();
        await instance<SharedPref>().setToken(state.token, );
        Navigator.pushNamedAndRemoveUntil(context, Routes.homePage, (route) => false);
      }
      if(state is LoginError){
        showToast(state.err.message, ToastType.error);
      }

    },child: content(),);
  }
  Widget content(){
    return
      Scaffold(
        backgroundColor: Colors.grey[100],
        body: ListView(shrinkWrap: true,padding: EdgeInsets.only(bottom: 20,top: 20,left: 20,right: 20),

          children: [
            Align(alignment: Alignment.centerLeft,child: Text(' مركز التطوير المؤسسي : by',style: TextStyle(color: MyColor.colorBlack2),),),
            SizedBox(height: 60,),
            Image.asset('assets/images/hakayety_title.png',width: 200,fit: BoxFit.fitWidth,),
            const Text(
              'تسجيل الدخول',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                  labelText: "اسم المستخدم" ,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'كلمة المرور',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: (){bloc.checkId(_usernameController.text, _passwordController.text);},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(60),backgroundColor: MyColor.colorPrimary,foregroundColor: MyColor.colorWhite,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
              ),
              child: const Text('تسجيل الدخول'),
            ),
            const SizedBox(height: 16),
            Text(
              _message,
              style: TextStyle(
                color: _message == 'Login successful' ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      );
  }
}
