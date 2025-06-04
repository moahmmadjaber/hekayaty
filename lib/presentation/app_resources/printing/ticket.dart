import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:hekayaty/app/di.dart';
import 'package:hekayaty/app/extensions.dart';
import 'package:hekayaty/app/shared_pref.dart';
import 'package:hekayaty/presentation/app_resources/color_manager.dart';
import 'package:hekayaty/presentation/app_resources/enum_manager.dart';
import 'package:hekayaty/presentation/widgits/my_constant.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/helpers/sunmi_helper.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';
import 'package:sunmi_printer_plus/core/sunmi/sunmi_printer.dart';

import '../../../app/constants.dart';
import '../../../data/model/categories_model/categories_model.dart';
import '../../../data/model/confirmation_model/confirmation_model.dart';
import '../../../data/model/tickets_model/tickets_model.dart';

class TicketPrinting {
  static printInvoice({
    required BuildContext context,required CategoriesModel model,
    required ConfirmationModel item,
    required String flowerName,
    required String flowerPhone,
    required int childrenCount,
    required int flowerCount
  }) async {
    ScreenshotController screenshotController = ScreenshotController();
    try {
      Uint8List byte = await SunmiHelper.getImageFromAsset(
        'assets/images/black_icon.png',
      );
      String username = await instance<SharedPref>().getUsername();

      await SunmiPrinter.initPrinter();
      Uint8List header = await screenshotController.captureFromWidget(
        context: context,
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
                  Text(' : وقت الوصل ', style: TextStyle(fontSize: 10)),
                ],
              ),
            ),

            SizedBox(
              width: 200,
              child: Divider(color: MyColor.colorGray2, thickness: 0.25),
            ),
            SizedBox(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(flowerName, style: TextStyle(fontSize: 10)),
                  Text(' : اسم المرافق ', style: TextStyle(fontSize: 10)),
                ],
              ),
            ),
            SizedBox(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(flowerPhone, style: TextStyle(fontSize: 10)),
                  Text(' : رقم الهاتف', style: TextStyle(fontSize: 10)),
                ],
              ),
            ),
            SizedBox(
              width: 210,
              child: Divider(color: MyColor.colorGray2, thickness: 0.25),
            ),
          ],
        ),pixelRatio: printingPixelRatio
      );
      Uint8List table = await screenshotController.captureFromWidget(
        context: context,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ItemsWidget(
              items: item.items!,
              childrenCount: childrenCount, flowerCount: flowerCount,
            ),
            SizedBox(
              width: 180,
              child: Center(
                child: Text(
                  'المجموع قبل الخصم: ${item.amountBeforeDiscount.toNumber()} د.ع ',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            SizedBox(
              width: 180,
              child: Center(
                child: Text(
                  'المجموع بعد الخصم: ${item.totalAmount.toNumber()} د.ع ',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(width: 170, child: Align(alignment: Alignment.centerRight,child: Text(item.cashierName.toString(),style: TextStyle(fontSize: 10),))),
          ],
        ),pixelRatio: printingPixelRatio
      );
      await SunmiPrinter.printImage(byte, align: SunmiPrintAlign.RIGHT);
      await SunmiPrinter.printImage(header, align: SunmiPrintAlign.RIGHT);
      await SunmiPrinter.printText(
        '**** ${model.name} ****',
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

  final int childrenCount;
  final int flowerCount;

  const ItemsWidget({
    super.key,
    required this.items,
    required this.childrenCount,
    required this.flowerCount,
  });

  @override
  Widget build(BuildContext context) {
    final rows =
        items.map<DataRow>((s) {
          return DataRow(
            cells: [
              DataCell(
                SizedBox(
                  width: 50,
                  child: Text(
                    s.totalPrice.toNumber(),
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 40,
                  child: Text(
                    s.unitPrice.toNumber(),
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 25,
                  child: Text(
                    s.quantity.toString(),
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 100,
                  child: Text(
                    s.subCategoryName.toString(),
                    style: TextStyle(fontSize: 10),
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
          DataColumn(label: Text('السعر', style: TextStyle(fontSize: 10))),
          DataColumn(label: Text('عدد', style: TextStyle(fontSize: 10))),
          DataColumn(
            label: SizedBox(
              width: 100,
              child: Center(
                child: Text('الأسم', style: TextStyle(fontSize: 10)),
              ),
            ),
          ),
        ],
        rows: rows,
      ),
    );
  }
}
