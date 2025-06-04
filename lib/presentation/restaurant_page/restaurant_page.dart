import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:hekayaty/app/extensions.dart';
import 'package:hekayaty/presentation/app_resources/enum_manager.dart';
import 'package:hekayaty/presentation/widgits/my_constant.dart';

import '../../business_logic/restaurant/restaurant_cubit.dart';
import '../../data/model/categories_model/categories_model.dart';
import '../../data/model/school_supply_model/school_supply_model.dart';
import '../app_resources/color_manager.dart';
import '../app_resources/printing/restaurant.dart';
import '../widgits/ticket_card.dart';

InputBorder border = OutlineInputBorder(
  borderSide: BorderSide(color: MyColor.colorBlack3),
  borderRadius: BorderRadius.circular(5),
);

class RestaurantPage extends StatefulWidget {
  final CategoriesModel item;

  const RestaurantPage({super.key, required this.item});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  ValueNotifier<double> total = ValueNotifier(0);
  List<ReceiptModel> items = [
    ReceiptModel(
      id: 1,
      name: TextEditingController(),
      count: TextEditingController(),
      price: TextEditingController(),
      total: ValueNotifier(''),
    ),
  ];
  List<SubCategories>subCategories=[];
  late RestaurantCubit bloc;
  List<SubCategories> selectedTickets = [];

  @override
  void initState() {
    bloc = BlocProvider.of<RestaurantCubit>(context);
    bloc.getSubCategory(widget.item.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.lowGray,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.item.name.toString(), style: TextStyle(color: MyColor.colorWhite)),
      ),body: BlocConsumer<RestaurantCubit, RestaurantState>(
      listener: (context, state) {
        if (state is OrderLoading) {
          showToast('جاري التحميل', ToastType.load);
        }

        if (state is OrderError) {
          showToast(state.err.message, ToastType.error);
        }
        if (state is OrderComplete) {
          RestaurantPrinter.printRestaurantPrinterInvoice(
            context,widget.item,
            state.model,
          ).whenComplete(() {
            bloc.orderComplete(state.model.id);
            EasyLoading.dismiss();
            showToast('تم طباعة الفاتورة بنجاح', ToastType.success);
            Navigator.pop(context);
          });
        }
      },
      builder: (BuildContext context, RestaurantState state) {
        if (state is GetSubCategoryLoading) {
          return Loading();
        }
        if(state is GetSubCategoryError){
          return failed((){bloc.getSubCategory(widget.item.id!);});
        }
        if (state is GetSubCategoryComplete) {
          subCategories=state.model;
          return content();
        } else {
          return content();

        }
      },
    ),);
  }

  Widget content() {
    return  ListView(
        padding: EdgeInsets.symmetric(vertical: 20),
        children: [
          GridView.builder(
            itemCount: subCategories.length ?? 0,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Divider(color: MyColor.colorBlack2),
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
                child: Text("   ", textAlign: TextAlign.center),
              ),
            ],
          ),
          SizedBox(height: 20),
          ItemsWidget(
            items: selectedTickets,
            onRemoveOne: (int itemId) {
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
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  if(selectedTickets.isNotEmpty) {
                    bloc.order(selectedTickets);
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
