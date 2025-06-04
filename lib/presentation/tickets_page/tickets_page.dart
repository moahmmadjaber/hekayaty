import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:hekayaty/app/extensions.dart';
import 'package:hekayaty/business_logic/tickets/tickets_cubit.dart';
import 'package:hekayaty/data/model/categories_model/categories_model.dart';
import 'package:hekayaty/data/model/tickets_model/tickets_model.dart';
import 'package:hekayaty/presentation/app_resources/color_manager.dart';
import 'package:hekayaty/presentation/app_resources/enum_manager.dart';
import 'package:hekayaty/presentation/app_resources/printing/ticket.dart';
import 'package:hekayaty/presentation/widgits/my_constant.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../data/model/tickets_model/tickets_model.dart';
import '../widgits/ticket_card.dart';

InputBorder border = OutlineInputBorder(
  borderSide: BorderSide(color: MyColor.colorBlack3),
  borderRadius: BorderRadius.circular(5),
);

class TicketsPage extends StatefulWidget {
  final CategoriesModel item;

  const TicketsPage({super.key, required this.item});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  int flowersCount = 0;
  int kidsCount = 0;
  int discount = 0;
  TextEditingController flowersName = TextEditingController();
  TextEditingController flowerPhone = TextEditingController();
  TextEditingController discountNotes = TextEditingController();
  ValueNotifier<double>total=ValueNotifier(0);

  SubCategories flowerModel=SubCategories(id: 9,name:"مرافقين",description: "مرافقين",price:2000,wholesalePrice: 0,mainCategoryId: 21,mainCategoryName: "تذاكر" ,active: true);
  List<SubCategories> selectedTickets = [];
  late TicketsCubit bloc;
  List<SubCategories> subCategories = [];

  @override
  void initState() {
    bloc = BlocProvider.of<TicketsCubit>(context);
    bloc.getSubCategory(widget.item.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: MyColor.colorWhite),
        backgroundColor: MyColor.colorPrimary,
        title: Text(widget.item.name.toString(), style: TextStyle(color: MyColor.colorWhite)),
        centerTitle: true,
      ),body: BlocConsumer<TicketsCubit, TicketsState>(
      listener: (context, state) {
        if (state is OrderLoading) {
          showToast('جاري التحميل', ToastType.load);
        }

        if (state is OrderError) {
          showToast(state.err.message, ToastType.error);
        }
        if (state is OrderComplete) {
          TicketPrinting.printInvoice(
            context: context,model: widget.item,
            item: state.model,
            flowerName: flowersName.text,
            flowerPhone: flowerPhone.text,
            childrenCount: kidsCount,
            flowerCount: flowersCount,
          ).whenComplete(() {
            bloc.orderComplete(state.model.id);
            EasyLoading.dismiss();
            showToast('تم طباعة الفاتورة بنجاح', ToastType.success);
            Navigator.pop(context);
          });
        }
      },
      builder: (BuildContext context, TicketsState state) {
        if (state is GetSubCategoryLoading) {
          return Loading();
        }
        if (state is GetSubCategoryError) {
          return failed(() {
            bloc.getSubCategory(widget.item.id!);
          });
        }
        if (state is GetSubCategoryComplete) {
          subCategories = state.model;
          return content();
        } else {
          return content();
        }
      },
    ),);

  }

  Widget content() {
    return ListView(
        padding: EdgeInsets.symmetric(vertical: 20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("اعداد المرافقين:   ", style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return NumberPickerDialog(
                              onSave: (int newValue) {
                                setState(() {
                                  flowersCount = newValue;
                                  total.value = flowersCount*flowerModel.price!+selectedTickets.fold<double>(
                                    0,
                                        (previousValue, element) => previousValue + (element.price!*kidsCount)!,
                                  );
                                });
                              },
                              startingNumber: flowersCount,
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: MyColor.lowGray,
                          border: Border.all(color: MyColor.colorWhite),
                          boxShadow: [
                            BoxShadow(
                              color: MyColor.colorBlack2,
                              blurRadius: 5,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          flowersCount.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("اعداد الأولاد:   ", style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return NumberPickerDialog(
                              onSave: (int newValue) {
                                setState(() {
                                  kidsCount = newValue;
                                });
                              },
                              startingNumber: kidsCount,
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: MyColor.lowGray,
                          border: Border.all(color: MyColor.colorWhite),
                          boxShadow: [
                            BoxShadow(
                              color: MyColor.colorBlack2,
                              blurRadius: 5,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          kidsCount.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      Text("الخصم:   ", style: TextStyle(fontSize: 14)),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return NumberPickerDialog(
                                onSave: (int newValue) {
                                  setState(() {
                                    discount = newValue;
                                  });
                                },
                                startingNumber: discount,
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: MyColor.lowGray,
                            border: Border.all(color: MyColor.colorWhite),
                            boxShadow: [
                              BoxShadow(
                                color: MyColor.colorBlack2,
                                blurRadius: 5,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            '${discount.toString()}%',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("ملاحظات:   ", style: TextStyle(fontSize: 14)),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: MyColor.colorBlack3,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: discountNotes,
                            textAlign: TextAlign.center,
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Center(child: Text('معلومات المرافق')),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: MyColor.colorBlack2, blurRadius: 5)],
            ),
            child: TextField(
              controller: flowersName,
              decoration: InputDecoration(
                hintText: 'اسم المرافق',
                border: border,
                enabledBorder: border,
                focusedBorder: border,
                focusedErrorBorder: border,
                filled: true,
                fillColor: MyColor.lowGray,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: MyColor.colorBlack2, blurRadius: 5)],
            ),
            child: TextField(
              controller: flowerPhone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'رقم الهاتف',
                border: border,
                enabledBorder: border,
                focusedBorder: border,
                focusedErrorBorder: border,
                filled: true,
                fillColor: MyColor.lowGray,
              ),
            ),
          ),
          SizedBox(height: 20),
          GridView.builder(
            itemCount: subCategories.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              var item = subCategories[index];
              return InkWell(
                onTap: () {
                  if (!selectedTickets.any((s) => s.id == item.id)) {
                    setState(() {
                      selectedTickets.add(item);
                    });
                  } else {
                    setState(() {
                      selectedTickets.remove(item);
                    });
                  }
                  total.value = flowersCount*flowerModel.price!+selectedTickets.fold<double>(
                    0,
                        (previousValue, element) => previousValue + (element.price!*kidsCount)!,
                  );
                },
                child: TicketCard(
                  model: item,
                  isSelected: (selectedTickets.any((s) => s.id == item.id)),
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("ت"),
              SizedBox(
                width: 100,
                child: Text("الأسم", textAlign: TextAlign.center),
              ),
              SizedBox(
                width: 60,
                child: Text("السعر", textAlign: TextAlign.center),
              ),
              SizedBox(
                width: 40,
                child: Text("العدد", textAlign: TextAlign.center),
              ),
              SizedBox(
                width: 100,
                child: Text("المجموع", textAlign: TextAlign.center),
              ),
            ],
          ),

          SizedBox(height: 20),
          if(selectedTickets.isNotEmpty)
          ItemsWidget(
            items: selectedTickets,
            flowerModel: flowerModel,
            childrenCount: kidsCount,
            flowerCount: flowersCount,
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
                ValueListenableBuilder(
                  valueListenable: total,
                  builder: (context, value, w) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: MyColor.lowGray,
                        border: Border.all(color: MyColor.colorBlack2),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(color: MyColor.colorBlack2, blurRadius: 5),
                        ],
                      ),
                      child: Text(
                        value.toNumber(),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          if(discount>0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('المجموع بعد الخصم'),
                  ValueListenableBuilder(
                    valueListenable: total,
                    builder: (context, value, w) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: MyColor.lowGray,
                          border: Border.all(color: MyColor.colorBlack2),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(color: MyColor.colorBlack2, blurRadius: 5),
                          ],
                        ),
                        child:Text(
                          (value - ((value * discount / 100).toInt() ~/ 250 * 250)).toNumber(),
                          textAlign: TextAlign.center,
                        )
                        ,
                      );
                    },
                  ),
                ],
              ),
            ),

          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  if (kidsCount == 0) {
                    showToast('يجب اختيار عدد الأطفال', ToastType.toast);
                  } else if (flowersName.text.isEmpty||flowersCount==0) {
                    showToast('يجب كتابة اسم وعدد المرافق', ToastType.toast);
                  }else if (flowerPhone.text.isEmpty) {
                    showToast('يجب كتابة رقم المرافق', ToastType.toast);
                  } else {
                    bloc.order(selectedTickets,flowerModel, flowersCount,kidsCount,discount,discountNotes.text,flowersName.text,flowerPhone.text);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: MyColor.colorGreen,
                    boxShadow: [
                      BoxShadow(color: MyColor.colorBlack2, blurRadius: 5),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: MyColor.colorWhite),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'طباعة الفاتورة',
                        style: TextStyle(
                          fontSize: 20,
                          color: MyColor.colorWhite,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.print, color: MyColor.colorWhite),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  }
}

class ItemsWidget extends StatelessWidget {
  final List<SubCategories> items;
  final SubCategories flowerModel;
  final int childrenCount;
  final int flowerCount;

  const ItemsWidget({
    super.key,
    required this.items,
    required this.childrenCount,
    required this.flowerCount,
    required this.flowerModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          [
            ...items.map(
              (s) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text((s.id).toString(), textAlign: TextAlign.center),
                    SizedBox(
                      width: 100,
                      child: Text(
                        s.name.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: Text(
                        s.price.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: Text(
                        childrenCount.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        (childrenCount * s.price!).toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    (flowerModel!.id).toString(),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      flowerModel!.name.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Text(
                      flowerModel!.price.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(
                      flowerCount.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      (flowerCount *( flowerModel.price??0))
                          .toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ].toList(),
    );
  }
}

class NumberPickerDialog extends StatelessWidget {
  final int startingNumber;
  final void Function(int newValue) onSave;

  const NumberPickerDialog({
    super.key,
    required this.onSave,
    required this.startingNumber,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> currentValue = ValueNotifier(startingNumber);
    return ValueListenableBuilder(
      valueListenable: currentValue,
      builder: (context, value, w) {
        return Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: MyColor.colorWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 250,
                child: NumberPicker(
                  value: value,
                  itemCount: 6,
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColor.colorPrimary),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  minValue: 0,
                  textStyle: TextStyle(
                    fontFamily: 'dinn',
                    color: MyColor.colorBlack2,
                    fontSize: 15,
                  ),
                  selectedTextStyle: TextStyle(
                    fontFamily: 'dinn',
                    color: MyColor.colorBlack,
                    fontSize: 20,
                  ),
                  maxValue: 100,
                  onChanged: (value) {
                    currentValue.value = value;
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  onSave(currentValue.value);
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor: MyColor.colorPrimary,
                  fixedSize: Size(150, 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('حفظ', style: TextStyle(color: MyColor.colorWhite)),
              ),
            ],
          ),
        );
      },
    );
  }
}
