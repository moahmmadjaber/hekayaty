import 'package:flutter/material.dart';
import 'package:hekayaty/presentation/app_resources/color_manager.dart';
import 'package:numberpicker/numberpicker.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  int flowersCount = 0;
  int kidsCount = 0;

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
              Flexible(fit: FlexFit.tight,child: Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("اعداد المرافقين:   ", style: TextStyle(fontSize: 20)),
                ],
              )),
              Flexible(fit: FlexFit.tight,
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
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
                                });
                              }, startingNumber: flowersCount,
                            );
                          },
                        );
                      },
                      child: Container(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        decoration: BoxDecoration(
                          color: MyColor.lowGray,
                          border: Border.all(color: MyColor.colorWhite),
                          boxShadow: [
                            BoxShadow(color: MyColor.colorBlack2, blurRadius: 5),
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(flowersCount.toString(),style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(fit: FlexFit.tight,child: Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("اعداد الأولاد:   ", style: TextStyle(fontSize: 20)),
                ],
              )),
      Flexible(fit: FlexFit.tight,
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
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
                              }, startingNumber: kidsCount,
                            );
                          },
                        );
                      },
                      child: Container(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        decoration: BoxDecoration(
                          color: MyColor.lowGray,
                          border: Border.all(color: MyColor.colorWhite),
                          boxShadow: [
                            BoxShadow(color: MyColor.colorBlack2, blurRadius: 5),
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(kidsCount.toString(),style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NumberPickerDialog extends StatelessWidget {
 final  int startingNumber;
  final void Function(int newValue) onSave;

  const NumberPickerDialog({super.key, required this.onSave, required this.startingNumber});

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
