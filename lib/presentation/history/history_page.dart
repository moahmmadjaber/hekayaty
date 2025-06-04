import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:hekayaty/app/extensions.dart';
import 'package:hekayaty/business_logic/history/history_cubit.dart';
import 'package:hekayaty/data/model/history_model/history_model.dart';
import 'package:hekayaty/presentation/app_resources/color_manager.dart';
import 'package:hekayaty/presentation/app_resources/enum_manager.dart';
import 'package:hekayaty/presentation/app_resources/printing/history.dart';
import 'package:hekayaty/presentation/widgits/my_constant.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<HistoryModel> historyList = [];
  late HistoryCubit bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<HistoryCubit>(context);
    bloc.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
        centerTitle: true,
        title: const Text(
        'سجل الطلبات',
        style: TextStyle(color: MyColor.colorWhite),
    ),
    ),
    body:BlocConsumer<HistoryCubit, HistoryState>(builder: (context, state){
      if (state is GetHistoryLoading) {
    return Loading();
      }
      if (state is HistoryError) {
        return failed((){bloc.get();});
      }

      else{
        return content();
      }
    },
      listener: (context, state) {
        if (state is GetHistoryLoading) {
          showToast('جاري التحميل', ToastType.load);
        }
        if (state is HistoryError) {
          showToast(state.err, ToastType.error);
        }
        if (state is GetHistoryComplete) {
          EasyLoading.dismiss();
          setState(() {
            historyList = state.model;
          });
        }
      },

    ));
  }
  Widget content(){
    return
      ListView.builder(
          itemCount: historyList.length,
          itemBuilder: (context, index) {
            final history = historyList[index];
            return Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: ExpansionTile(
                backgroundColor: MyColor.colorPrimary,
                shape: RoundedRectangleBorder(side: BorderSide(color: MyColor.colorWhite),
                  borderRadius: BorderRadius.circular(10),
                ),
                textColor: MyColor.colorWhite,
                title: Text(" رقم الوصل :${history.id ?? 'N/A'}"),
                subtitle: Text(
                  "التاريخ: ${history.orderDate.toDate() ?? ''}",
                ),
                children: [
                  _buildTileInfo("الحالة", history.status),
                  _buildTileInfo("طريقة الدفع", history.paymentMethod),
                  _buildTileInfo(
                    "مجموع المبلغ",
                    "${history.totalAmount.toNumber() ?? 0}",
                  ),
                  _buildTileInfo(
                    "قبل الخصم",
                    "${history.amountBeforeDiscount.toNumber() ?? 0}",
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "التفاصيل",
                      style: TextStyle(color: MyColor.colorWhite),
                    ),
                  ),
                  ...?history.items?.map(
                        (item) => ListTile(
                      title: Text(
                        item.subCategoryName ?? 'Item',
                        style: TextStyle(color: MyColor.colorWhite),
                      ),
                      subtitle: Text(
                        "العدد: ${item.quantity.toNumber()}, المفرد: ${item.unitPrice.toNumber()}",
                        style: TextStyle(color: MyColor.colorWhite),
                      ),
                      trailing: Text(
                        "المجموع: ${item.totalPrice.toNumber()}",
                        style: TextStyle(color: MyColor.colorWhite),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      HistoryPrinter.printHistoryInvoice(
                        context,
                        history,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: MyColor.primaryGold,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: MyColor.colorBlack3),
                        boxShadow: [
                          BoxShadow(
                            color: MyColor.colorBlack3,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.print, color: MyColor.colorBlack),
                          Text(
                            'اعادة طباعة',
                            style: TextStyle(color: MyColor.colorBlack),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
  }

  Widget _buildTileInfo(String label, String? value) {
    return ListTile(
      dense: true,
      title: Text(label, style: TextStyle(color: MyColor.colorWhite)),
      trailing: Text(
        value ?? "N/A",
        style: TextStyle(color: MyColor.colorWhite),
      ),
    );
  }
}
