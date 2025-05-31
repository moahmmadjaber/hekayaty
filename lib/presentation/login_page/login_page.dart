import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hekayaty/business_logic/login/login_cubit.dart';
import 'package:hekayaty/presentation/app_resources/color_manager.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit,LoginState>(listener: (context,state){

    },child: content(),);
  }
  Widget content(){
    return
      Scaffold(
        backgroundColor: Colors.grey[100],
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                  onPressed: (){Navigator.pushNamed(context, Routes.homePage);},
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
          ),
        ),
      );
  }
}
