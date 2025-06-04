import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:hekayaty/app/extensions.dart';
import 'package:hekayaty/business_logic/swimming_pool/swimming_pool_cubit.dart';
import 'package:hekayaty/presentation/app_resources/color_manager.dart';
import 'package:hekayaty/presentation/app_resources/printing/swimming_pool.dart';
import 'package:numberpicker/numberpicker.dart';


import '../../data/model/categories_model/categories_model.dart';
import '../app_resources/enum_manager.dart';
import '../widgits/my_constant.dart';
import '../widgits/ticket_card.dart';
InputBorder border = OutlineInputBorder(
  borderSide: BorderSide(color: MyColor.colorBlack3),
  borderRadius: BorderRadius.circular(5),
);
class SwimmingPoolPage extends StatefulWidget {
  final CategoriesModel item;
  const SwimmingPoolPage({super.key, required this.item});




  @override
  State<SwimmingPoolPage> createState() => _SwimmingPoolPageState();
}

class _SwimmingPoolPageState extends State<SwimmingPoolPage> {
  late SwimmingPoolCubit bloc;
  List<SubCategories>subCategories=[];
  List<SubCategories>selectedTickets=[];
  ValueNotifier<double> total = ValueNotifier(0);
  int discount=0;
  TextEditingController discountNotes=TextEditingController();
  @override
  void initState() {
    bloc=BlocProvider.of<SwimmingPoolCubit>(context);
    bloc.getSubCategory(widget.item.id!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: MyColor.colorWhite),
        backgroundColor: MyColor.colorPrimary,
        title:Text(widget.item.name.toString(), style: TextStyle(color: MyColor.colorWhite)),
        centerTitle: true,
      ),body: BlocConsumer<SwimmingPoolCubit, SwimmingPoolState>(
      listener: (context, state) {
        if (state is OrderLoading) {
          showToast('جاري التحميل', ToastType.load);
        }

        if (state is OrderError) {
          showToast(state.err.message, ToastType.error);
        }
        if (state is OrderComplete) {
          SwimmingPool.printInvoice(
            context: context,model:widget.item,
            item: state.model,
          ).whenComplete(() {
            bloc.orderComplete(state.model.id);
            EasyLoading.dismiss();
            showToast('تم طباعة الفاتورة بنجاح', ToastType.success);
            Navigator.pop(context);
          });
        }
      },
      builder: (BuildContext context, SwimmingPoolState state) {
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
    setState(() {
    selectedTickets.add(item);
    total.value = selectedTickets.fold<double>(
    0,
    (previousValue, element) =>
    previousValue + element.price!,
    );
    });

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
            SizedBox(
              width: 50,
            ),
          ],
        ),
        SizedBox(height: 20),
        ItemsWidget(
          items: selectedTickets,       onRemoveOne: (int itemId) {
          setState(() {
            final index = selectedTickets.indexWhere(
                  (item) => item.id == itemId,
            );
            if (index != -1) {
              selectedTickets.removeAt(index);
            }
            total.value = selectedTickets.fold<double>(
              0,
                  (previousValue, element) => previousValue + element.price!,
            );
          });
        },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Divider(color: MyColor.colorBlack2),
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
        SizedBox(height: 20),
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
                    child: Text(
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
                  bloc.order(selectedTickets, discount, discountNotes.text);

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
  final void Function(int itemId) onRemoveOne;

  const ItemsWidget({
    super.key,
    required this.items,
    required this.onRemoveOne,
  });

  @override
  @override
  Widget build(BuildContext context) {
    // Group items and track first occurrence index
    final Map<int, _GroupedItem> groupedItems = {};
    final Map<int, int> firstIndexMap = {}; // itemId -> index

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final itemId = item.id!;
      if (groupedItems.containsKey(itemId)) {
        groupedItems[itemId]!.count += 1;
      } else {
        groupedItems[itemId] = _GroupedItem(item: item, count: 1);
        firstIndexMap[itemId] = i; // Save the index of first appearance
      }
    }

    // Sort grouped items based on their first occurrence in the original list
    final groupedValues = groupedItems.values.toList()
      ..sort((a, b) {
        final aIndex = firstIndexMap[a.item.id!]!;
        final bIndex = firstIndexMap[b.item.id!]!;
        return aIndex.compareTo(bIndex);
      });

    return Column(
      children: [
        ...groupedValues.map(
              (group) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    group.item.name.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: Text(
                    group.item.price.toNumber(),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Text(
                    group.count.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    (group.item.price! * group.count).toNumber(),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () => onRemoveOne(group.item.id!),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

}

class _GroupedItem {
  final SubCategories item;
  int count;

  _GroupedItem({required this.item, this.count = 1});
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
