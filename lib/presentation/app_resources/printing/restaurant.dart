import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hekayaty/app/extensions.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/helpers/sunmi_helper.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';
import 'package:sunmi_printer_plus/core/sunmi/sunmi_printer.dart';

import '../../../app/constants.dart';
import '../../../app/di.dart';
import '../../../app/shared_pref.dart';
import '../../../data/model/categories_model/categories_model.dart';
import '../../../data/model/confirmation_model/confirmation_model.dart';
import '../../../data/model/school_supply_model/school_supply_model.dart';
import '../../widgits/my_constant.dart';
import '../color_manager.dart';
import '../enum_manager.dart';

class RestaurantPrinter {
  static Future<void> printRestaurantPrinterInvoice(
    BuildContext context,CategoriesModel model,
    ConfirmationModel item,
  ) async {
    ScreenshotController screenshotController = ScreenshotController();
    double total = (item.items!.fold(
      0,
      (previousValue, element) => previousValue + element.totalPrice!,
    ));
    try {
      Uint8List byte = await SunmiHelper.getImageFromAsset(
        'assets/images/black_icon.png',
      );

      await SunmiPrinter.initPrinter();
      Uint8List header = await screenshotController.captureFromWidget(
        context: context,pixelRatio: printingPixelRatio,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 200,
              child: Divider(color: MyColor.colorGray2, thickness: 0.5),
            ),
            Text('رقم الوصل :${item.id} ', style: TextStyle(fontSize: 10)),
            Text(
              'تاريخ الوصل: ${item.orderDate.toDate()}',
              style: TextStyle(fontSize: 10),
            ),
            SizedBox(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(item.orderDate.toTime(), style: TextStyle(fontSize: 10)),
                  Text(' : وقت الوصل', style: TextStyle(fontSize: 10)),
                ],
              ),
            ),

            SizedBox(
              width: 210,
              child: Divider(color: MyColor.colorGray2, thickness: 0.25),
            ),
          ],
        ),
      );
      Uint8List table = await screenshotController.captureFromWidget(pixelRatio: printingPixelRatio,
        context: context,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ItemsWidget(items: item.items!),
            SizedBox(
              width: 180,
              child: Divider(color: MyColor.colorGray2, thickness: 0.25),
            ),
            SizedBox(
              width: 180,
              child: Center(
                child: Text(
                  'المجموع : ${total.toNumber()} د.ع ',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(width: 170, child: Align(alignment: Alignment.centerRight,child: Text(item.cashierName.toString(),style: TextStyle(fontSize: 10),))),
            // SizedBox(
            //   width: 180,
            //   child: Center(
            //     child: Text(
            //       'المجموع بعد الخصم: ${total - (total * discount / 100)} د.ع ',
            //       style: TextStyle(fontSize: 10),
            //     ),
            //   ),
            // ),

          ],
        ),
      );
      await SunmiPrinter.printImage(byte, align: SunmiPrintAlign.RIGHT);
      await SunmiPrinter.printImage(header, align: SunmiPrintAlign.RIGHT);
      await SunmiPrinter.printText(
        '**** تذكرة ${model.name} ****',
        style: SunmiTextStyle(align: SunmiPrintAlign.CENTER, bold: true),
      );
      await SunmiPrinter.printImage(table, align: SunmiPrintAlign.RIGHT);
      await SunmiPrinter.lineWrap(20);

      await SunmiPrinter.cutPaper();
      await SunmiPrinter.exitTransactionPrint(true);
    } catch (e) {
      showToast(e.toString(), ToastType.error);
      print('Print failed: $e');
    }
  }
}

class ItemsWidget extends StatelessWidget {
  final List<Items> items;

  const ItemsWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    // Grouping logic

    // for (var item in items) {
    //   if (groupedItems.containsKey(item.id)) {
    //     groupedItems[item.id]!.count += 1;
    //   } else {
    //     groupedItems[item.id!] = _GroupedItem(item: item, count: 1);
    //   }
    // }

    // Build rows from grouped data
    final rows =
        items.map<DataRow>((data) {
          return DataRow(
            cells: [
              DataCell(
                SizedBox(
                  width: 60,
                  child: Text(
                    data.totalPrice.toString(),
                    style: const TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 60,
                  child: Text(
                    data.unitPrice!.toNumber(),
                    style: const TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 25,
                  child: Text(
                    data.quantity.toString(),
                    style: const TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 65,
                  child: Text(
                    data.subCategoryName.toString(),
                    style: const TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          );
        }).toList();

    return IntrinsicWidth(
      child: DataTable(
        columnSpacing: 0,
        horizontalMargin: 0,
        dataRowMinHeight: 24,
        dataRowMaxHeight: 28,
        headingRowHeight: 28,
        columns: const [
          DataColumn(label: Text('المجموع', style: TextStyle(fontSize: 10))),
          DataColumn(label: Text('سعر المفرد', style: TextStyle(fontSize: 10))),
          DataColumn(label: Text('العدد', style: TextStyle(fontSize: 10))),
          DataColumn(
            label: SizedBox(
              width: 65,
              child: Center(
                child: Text('النوع', style: TextStyle(fontSize: 10)),
              ),
            ),
          ),
        ],
        rows: rows,
      ),
    );
  }
}
