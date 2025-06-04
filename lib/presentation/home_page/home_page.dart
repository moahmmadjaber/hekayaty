import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hekayaty/app/di.dart';
import 'package:hekayaty/app/extensions.dart';
import 'package:hekayaty/app/icons.dart';
import 'package:hekayaty/app/shared_pref.dart';
import 'package:hekayaty/business_logic/home/home_cubit.dart';
import 'package:hekayaty/data/model/categories_model/categories_model.dart';
import 'package:hekayaty/presentation/app_resources/color_manager.dart';
import 'package:hekayaty/presentation/app_resources/enum_manager.dart';
import 'package:hekayaty/presentation/widgits/my_constant.dart';
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
  late HomeCubit bloc;
  List<CategoriesModel> model = [];

  @override
  void initState() {
    bloc = BlocProvider.of<HomeCubit>(context);
    bloc.checkIsActive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is CheckIsActiveComplete) {
          if (!state.status) {
            instance<SharedPref>().removeUser();
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.splash,
              (route) => false,
            );
          } else {
            bloc.getCategories();
          }
        }
        if (state is HomeLoading) {
          showToast('جاري التحميل', ToastType.load);
        }
        if (state is GetCategoriesComplete) {
          EasyLoading.dismiss();
          setState(() {
            model = state.model;
          });
        }
        if (state is GetCategoriesError) {
          showToast(state.err.message, ToastType.error);
        }
      },
      builder: (BuildContext context, HomeState state) {
        if (state is HomeLoading) {
          return Loading();
        }
        if (state is GetCategoriesComplete) {
          return content();
        }
        if (state is HomeError) {
          return failed(() {
            bloc.checkIsActive();
          });
        } else {
          return content();
        }
      },
    );
  }

  Widget content() {
    return Scaffold(
      backgroundColor: MyColor.lowGray,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('تحذير',textAlign: TextAlign.center,),
                  content: Text('هل انت متأكد من تسجيل الخروج؟'),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () async {
                            await instance<SharedPref>().removeUser();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.splash,
                              (route) => false,
                            );
                          },
                          child: Text(
                            'نعم',
                            style: TextStyle(color: MyColor.colorGreen),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                        Navigator.pop(context);
                          },
                          child: Text(
                            'لا',
                            style: TextStyle(color: MyColor.colorRed),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
          icon: Icon(Icons.logout_rounded),
        ),
        centerTitle: true,
        backgroundColor: MyColor.colorPrimary,
        title: Text('الرئيسية', style: TextStyle(color: MyColor.colorWhite)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.history);
            },
            icon: Icon(Icons.history, color: MyColor.colorWhite),
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            itemCount: model.length,
            physics: NeverScrollableScrollPhysics(),

            padding: EdgeInsets.symmetric(horizontal: 10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (BuildContext context, int index) {
              var item = model[index];
              return CurvedButton(
                // borderRadius: const BorderRadius.only(
                //   bottomLeft: Radius.circular(50),
                //   bottomRight: Radius.circular(50),
                // ),
                // color: MyColor.colorGreen,
                onTap: () {
                  categoryNavigate(item);
                },
                model: item,
              );
            },
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void categoryNavigate(CategoriesModel item) {
    switch (item.categoryType!) {
      case CategoryType.restaurant:
        Navigator.pushNamed(context, Routes.restaurant, arguments: item);
      case CategoryType.ticket:
        Navigator.pushNamed(context, Routes.ticketsPage, arguments: item);
      case CategoryType.schoolSupply:
        Navigator.pushNamed(context, Routes.schoolSupply, arguments: item);

      case CategoryType.cafeteria:
        Navigator.pushNamed(context, Routes.cafeteria, arguments: item);
      case CategoryType.swimmingPool:
        Navigator.pushNamed(context, Routes.swimmingPool, arguments: item);
    }
  }
}

class CurvedButton extends StatelessWidget {
  final CategoriesModel model;
  final void Function() onTap;

  const CurvedButton({super.key, required this.onTap, required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: EdgeInsets.all(10),
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          color: HexColor('#${model.color}'),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MyColor.lowGray),
          boxShadow: [BoxShadow(color: MyColor.colorBlack2, blurRadius: 5)],
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(model.name.toString(), style: TextStyle(color: Colors.white)),
            SizedBox(width: 10),
            Image.network(
              model.image.toString(),
              height: 30,
              fit: BoxFit.fitHeight,
              color: MyColor.colorWhite,
              errorBuilder: (context, error, stackTrace) {
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
