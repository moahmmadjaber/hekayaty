import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/restaurant/restaurant_cubit.dart';
import '../../data/model/school_supply_model/school_supply_model.dart';
import '../app_resources/color_manager.dart';
import '../app_resources/printing/restaurant.dart';
InputBorder border = OutlineInputBorder(
  borderSide: BorderSide(color: MyColor.colorBlack3),
  borderRadius: BorderRadius.circular(5),
);
class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  ValueNotifier<String>total=ValueNotifier('0');
  List<ReceiptModel> items = [
    ReceiptModel(
      id: 1,
      name: TextEditingController(),
      count: TextEditingController(),
      price: TextEditingController(),
      total: ValueNotifier(''),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocListener<RestaurantCubit,RestaurantState>(listener: (context,state){

    },child: content(),);
  }
  Widget content(){
    return
      Scaffold(backgroundColor: MyColor.lowGray,
        appBar: AppBar(centerTitle: true,
          title: Text('المطعم',style: TextStyle(color: MyColor.colorWhite,),),
        ),
        body:
        ListView(
          padding: EdgeInsets.symmetric(vertical: 20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("ت"),
                SizedBox(
                  width: 100,
                  child: Text("المادة", textAlign: TextAlign.center),
                ),
                SizedBox(
                  width: 60,
                  child: Text("العدد", textAlign: TextAlign.center),
                ),
                SizedBox(
                  width: 70,
                  child: Text("السعر", textAlign: TextAlign.center),
                ),
                SizedBox(
                  width: 100,
                  child: Text("المجموع", textAlign: TextAlign.center),
                ),
              ],
            ),
            SizedBox(height: 20),
            ItemsWidget(items: items, total: total,),
            SizedBox(height: 20),
            Align(
              alignment: Alignment(0.9, 0),
              child: IconButton(
                onPressed: () {
                  if (!items.any((i) => i.total.value.isEmpty)) {
                    setState(() {
                      items.add(
                        ReceiptModel(
                          id: items.last.id + 1,
                          name: TextEditingController(),
                          count: TextEditingController(),
                          price: TextEditingController(),
                          total: ValueNotifier(''),
                        ),
                      );
                    });
                  }
                },
                style: IconButton.styleFrom(
                  backgroundColor: MyColor.colorPrimary,
                  shape: CircleBorder(),
                ),
                icon: Icon(Icons.add, color: MyColor.colorWhite),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Divider(color: MyColor.colorBlack2),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('المجموع'),
                  ValueListenableBuilder(valueListenable: total,
                      builder: (context,value,w) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: MyColor.lowGray,
                            border: Border.all(color: MyColor.colorBlack2),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(color: MyColor.colorBlack2, blurRadius: 5),
                            ],
                          ),
                          child: Text(
                            value,textAlign: TextAlign.center,
                          ),
                        );
                      }
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => RestaurantPrinter.printRestaurantPrinterInvoice(items),
                  child: Container(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    decoration: BoxDecoration(color: MyColor.colorGreen,boxShadow: [BoxShadow(color: MyColor.colorBlack2,blurRadius: 5),],borderRadius: BorderRadius.circular(10),border: Border.all(color: MyColor.colorWhite)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'طباعة الفاتورة',
                          style: TextStyle(fontSize: 20, color: MyColor.colorWhite),
                        ),SizedBox(width: 10,),Icon(Icons.print,color: MyColor.colorWhite,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
  }
}




class ItemsWidget extends StatelessWidget {
  final List<ReceiptModel> items;
  final ValueNotifier<String>total;

  const ItemsWidget({super.key, required this.items, required this.total});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
      items
          .map(
            (s) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(s.id.toString(),textAlign: TextAlign.center),
              Container(
                width: 100,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: MyColor.colorBlack3,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: TextField(
                  controller: s.name,textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    isDense: true,
                    border: border,
                    filled: true,
                    fillColor: MyColor.colorWhite,

                    errorBorder: border,
                    enabledBorder: border,
                    focusedBorder: border,
                    focusedErrorBorder: border,
                  ),
                ),
              ),
              Container(
                width: 60,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: MyColor.colorBlack3,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: TextField(
                  controller: s.count,textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 12),
                  onChanged: (String f) {
                    s.total.value =
                        ((int.tryParse(s.price.text) ?? 0) *
                            (int.tryParse(s.count.text) ?? 0))
                            .toString();
                    total.value=(items.fold<int>(
                      0,
                          (previousValue, element) =>
                      previousValue +
                          (int.tryParse(element.total.value) ?? 0),
                    )).toString();
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    border: border,
                    filled: true,
                    fillColor: MyColor.colorWhite,
                    errorBorder: border,
                    enabledBorder: border,
                    focusedBorder: border,
                    focusedErrorBorder: border,
                  ),
                ),
              ),
              Container(
                width: 70,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: MyColor.colorBlack3,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: TextField(
                  controller: s.price,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 12),
                  onChanged: (String f) {
                    s.total.value =
                        ((int.tryParse(s.price.text) ?? 0) *
                            (int.tryParse(s.count.text) ?? 0))
                            .toString();
                    total.value=(items.fold<int>(
                      0,
                          (previousValue, element) =>
                      previousValue +
                          (int.tryParse(element.total.value) ?? 0),
                    )).toString();
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    border: border,
                    filled: true,
                    fillColor: MyColor.colorWhite,
                    errorBorder: border,
                    enabledBorder: border,
                    focusedBorder: border,
                    focusedErrorBorder: border,
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                child: ValueListenableBuilder(
                  builder: (context, value, w) {
                    return Text(value,textAlign: TextAlign.center,);
                  },
                  valueListenable: s.total,
                ),
              ),
            ],
          ),
        ),
      )
          .toList(),
    );
  }
}