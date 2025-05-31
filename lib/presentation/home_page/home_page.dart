import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hekayaty/app/icons.dart';
import 'package:hekayaty/business_logic/home/home_cubit.dart';
import 'package:hekayaty/presentation/app_resources/color_manager.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/helpers/sunmi_helper.dart';
import 'package:sunmi_printer_plus/core/sunmi/sunmi_config.dart';
import 'package:sunmi_printer_plus/core/sunmi/sunmi_printer.dart';

import '../app_resources/route_manger.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Scaffold(
        backgroundColor: MyColor.lowGray,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: MyColor.colorPrimary,
          title: Text('الرئيسية', style: TextStyle(color: MyColor.colorWhite)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 100,
              child: CurvedButton(
                text: "التذاكر",icon:AppIcons.tickets ,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                color: MyColor.colorPrimary, onTap: () { Navigator.pushNamed(context, Routes.ticketsPage); },
              ),
            ),
            SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: [
                // Top Button
                CurvedButton(
                  text: "قرطاسية",icon:AppIcons.schoolSupply ,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  color: MyColor.colorGreen, onTap: () { Navigator.pushNamed(context, Routes.schoolSupply); },
                ),
                // Bottom Button
                CurvedButton(
                  text: "مطعم",icon:AppIcons.restaurant ,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  color: MyColor.primaryGold, onTap: () {  },
                ),
                // Left Button
                CurvedButton(
                  text: "كافتريا",icon:AppIcons.cafeteria ,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  color: MyColor.colorBlack, onTap: () {  },
                ),
                // Right Button
                CurvedButton(
                  text: 'مسبح',icon:AppIcons.swimmingPool ,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                  color: MyColor.colorOrange, onTap: () {  },
                ),
                // Center Button
              ],
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class CurvedButton extends StatelessWidget {
  final String text;
  final BorderRadius borderRadius;
  final Color color;
  final String icon; 
  final void Function() onTap;

  const CurvedButton({
    Key? key,
    required this.text,
    required this.borderRadius,
    required this.color, required this.icon, required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap,borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: EdgeInsets.all(10),
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),border: Border.all(color: MyColor.lowGray),
          boxShadow: [BoxShadow(color: MyColor.colorBlack2, blurRadius: 5)],
        ),
        alignment: Alignment.center,
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: TextStyle(color: Colors.white)),
            SizedBox(width: 10,),
            SvgPicture.string(icon,height: 30,fit: BoxFit.fitHeight,color: MyColor.colorWhite,)
          ],
        ),
      ),
    );
  }
}
