import 'package:flutter/material.dart';
import 'package:hekayaty/data/model/tickets_model/tickets_model.dart';
import 'package:hekayaty/presentation/app_resources/color_manager.dart';
import 'package:hekayaty/presentation/app_resources/printing/ticket.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../data/model/tickets_model/tickets_model.dart';

InputBorder border = OutlineInputBorder(
  borderSide: BorderSide(color: MyColor.colorBlack3),
  borderRadius: BorderRadius.circular(5),
);

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  int flowersCount = 0;
  int kidsCount = 0;
  int discount=0;
  TextEditingController flowersName = TextEditingController();
  TextEditingController flowerPhone = TextEditingController();
  TextEditingController discountNotes = TextEditingController();
  List<TicketModel> tickets = [
    TicketModel(id: 1, name: 'العاب', price: "5000"),
    TicketModel(id: 2, name: 'فلك', price: "7000"),
    TicketModel(id: 3, name: 'فيزياء', price: "7000"),
    TicketModel(id: 4, name: 'العاب + فضاء', price: "12000"),
    TicketModel(id: 5, name: 'العاب + حبل', price: "10000"),
  ];
  TicketModel? flowerModel;
  List<TicketModel> selectedTickets = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: MyColor.colorWhite),
        backgroundColor: MyColor.colorPrimary,
        title: Text('انشاء تذكرة', style: TextStyle(color: MyColor.colorWhite)),
        centerTitle: true,
      ),
      body: ListView(
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
                                  flowerModel = TicketModel(
                                    id: tickets.last.id + 1,
                                    name: 'مرافقين',
                                    price: "3000",
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
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 2,
            crossAxisCount: 2,
            children:
                tickets
                    .map(
                      (item) => InkWell(
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
                        },
                        child: TicketCard(
                          model: item,
                          isSelected: (selectedTickets.any(
                            (s) => s.id == item.id,
                          )),
                        ),
                      ),
                    )
                    .toList(),
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
          ItemsWidget(
            items: selectedTickets,
            flowerModel: flowerModel,
            childrenCount: kidsCount,
            flowerCount: flowersCount,
          ),

          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap:
                    () => TicketPrinting.printInvoice(
                      items: selectedTickets,
                      childrenCount: kidsCount,
                      flowerCount: flowersCount,
                      flowerModel: flowerModel, context: context, flowerName: flowersName.text, flowerPhone: flowerPhone.text, discount: discount,
                    ),
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
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final TicketModel model;
  final bool isSelected;

  const TicketCard({super.key, required this.model, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? MyColor.colorGreen : MyColor.colorPrimary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: MyColor.colorWhite),
        boxShadow: [BoxShadow(color: MyColor.colorBlack2, blurRadius: 5)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(model.name, style: TextStyle(color: MyColor.colorWhite)),
          Text(model.price, style: TextStyle(color: MyColor.colorWhite)),
        ],
      ),
    );
  }
}

class ItemsWidget extends StatelessWidget {
  final List<TicketModel> items;
  final TicketModel? flowerModel;
  final int childrenCount;
  final int flowerCount;

  const ItemsWidget({
    super.key,
    required this.items,
    required this.childrenCount,
    required this.flowerCount,
    this.flowerModel,
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
                        (childrenCount * int.parse(s.price)).toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (flowerModel != null)
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
                        (flowerCount * int.parse(flowerModel!.price))
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
              Flexible(
                fit: FlexFit.tight,
                child: NumberPicker(
                  value: value,
                  itemCount: 7,
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
