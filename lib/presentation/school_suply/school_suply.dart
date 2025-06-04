import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hekayaty/app/extensions.dart';
import 'package:hekayaty/app/icons.dart';
import 'package:hekayaty/business_logic/school_supply/school_supply_cubit.dart';
import 'package:hekayaty/data/model/categories_model/categories_model.dart';
import 'package:hekayaty/presentation/app_resources/color_manager.dart';

import '../../data/model/school_supply_model/school_supply_model.dart';
import '../app_resources/barcode_scanner.dart';
import '../app_resources/enum_manager.dart';
import '../app_resources/printing/school_supply.dart';
import '../widgits/my_constant.dart';

InputBorder border = OutlineInputBorder(
  borderSide: BorderSide(color: MyColor.colorBlack3),
  borderRadius: BorderRadius.circular(5),
);

class SchoolSupply extends StatefulWidget {
  final CategoriesModel item;

  const SchoolSupply({super.key, required this.item});

  @override
  State<SchoolSupply> createState() => _SchoolSupplyState();
}

class _SchoolSupplyState extends State<SchoolSupply> {
  ValueNotifier<double> total = ValueNotifier(0);
  List<SubCategories> items = [];
  late SchoolSupplyCubit bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<SchoolSupplyCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SchoolSupplyCubit, SchoolSupplyState>(
      listener: (context, state) {
        if (state is OrderLoading) {
          showToast('جاري التحميل', ToastType.load);
        }

        if (state is OrderError) {
          showToast(state.err.message, ToastType.error);
        }
        if (state is OrderComplete) {
          EasyLoading.dismiss();
          SchoolSupplyPrinter.printSchoolSupplyInvoice(
            context,
            state.model,widget.item
          ).whenComplete(() {
            bloc.orderComplete(state.model.id);
            EasyLoading.dismiss();
            showToast('تم طباعة الفاتورة بنجاح', ToastType.success);
            Navigator.pop(context);
          });
        }
        if (state is GetSubCategoryLoading) {
          showToast("جاري التحميل", ToastType.load);
        }
        if (state is GetSubCategoryError) {
          showToast(state.err.message, ToastType.error);
        }
        if (state is GetSubCategoryComplete) {
          EasyLoading.dismiss();
          setState(() {
            items.add(state.model);
          });
          total.value = items.fold<double>(
            0,
            (previousValue, element) => previousValue + element.price!,
          );
        }
      },
      child: Scaffold(
        backgroundColor: MyColor.lowGray,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: MyColor.colorPrimary,
          title: Text(widget.item.name.toString(), style: TextStyle(color: MyColor.colorWhite)),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 30,
                  child: Text(" ", textAlign: TextAlign.center),
                ),
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
                SizedBox(
                  width: 30,
                  child: Text(" ", textAlign: TextAlign.center),
                ),
              ],
            ),
            SizedBox(height: 20),
            ItemsWidget(
              items: items,
              onRemoveOne: (int itemId) {
                setState(() {
                  final index = items.indexWhere((item) => item.id == itemId);
                  if (index != -1) {
                    items.removeAt(index);
                  }
                });
              },
              addOne: (SubCategories model) {
                setState(() {
                  items.add(model);
                });
              },
            ),
            SizedBox(height: 20),
            Center(
              child: InkWell(
                onTap: () async {

                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(

                      builder: (_) => const BarcodeScannerPage(),
                    ),
                  );

                  if (result != null) {
                    bloc.getSubCategory(result);
                  }
                },
                child: Container(
                  width: double.maxFinite,
                  height: 50,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: MyColor.lowGray,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: MyColor.colorBlack3),
                    boxShadow: [
                      BoxShadow(color: MyColor.colorBlack2, blurRadius: 5),
                    ],
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: SvgPicture.string(
                          AppIcons.barcode,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Icon(Icons.barcode_reader),
                    ],
                  ),
                ),
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
                            BoxShadow(
                              color: MyColor.colorBlack2,
                              blurRadius: 5,
                            ),
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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (items.isNotEmpty) {
                      bloc.order(items);
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
        ),
      ),
    );
  }
}

class ItemsWidget extends StatelessWidget {
  final List<SubCategories> items;
  final void Function(int itemId) onRemoveOne;
  final void Function(SubCategories model) addOne;

  const ItemsWidget({
    super.key,
    required this.items,
    required this.onRemoveOne,
    required this.addOne,
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
    final groupedValues =
        groupedItems.values.toList()..sort((a, b) {
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
                IconButton(
                  icon: const Icon(Icons.add_circle_outline_rounded),
                  onPressed: () => addOne(group.item),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    group.item.name.toString(),
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
                  width: 70,
                  child: Text(
                    group.item.price.toNumber(),
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
