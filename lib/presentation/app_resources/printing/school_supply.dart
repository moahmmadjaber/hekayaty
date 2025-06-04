import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hekayaty/app/extensions.dart';
import 'package:hekayaty/data/model/confirmation_model/confirmation_model.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/helpers/sunmi_helper.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';
import 'package:sunmi_printer_plus/core/sunmi/sunmi_printer.dart';

import '../../../app/constants.dart';
import '../../../data/model/categories_model/categories_model.dart';
import '../color_manager.dart';

class SchoolSupplyPrinter {
  static Future<void> printSchoolSupplyInvoice(
    BuildContext context,
    ConfirmationModel items,
    CategoriesModel model,
  ) async {
    try {
      ScreenshotController screenshotController = ScreenshotController();
      Uint8List byte = await SunmiHelper.getImageFromAsset(
        'assets/images/black_icon.png',
      );

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
            Text('رقم الوصل :${items.id} ', style: TextStyle(fontSize: 10)),
            Text(
              'تاريخ الوصل: ${items.orderDate.toDate()}',
              style: TextStyle(fontSize: 10),
            ),
            SizedBox(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(items.orderDate.toTime(), style: TextStyle(fontSize: 10)),
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
        pixelRatio: printingPixelRatio,
      );
      Uint8List table = await screenshotController.captureFromWidget(
        context: context,
        SizedBox(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children:[  SizedBox(
            width: 200,
            child: Divider(color: MyColor.colorGray2, thickness: 0.25),
          ),...(items.items ?? [])
                .map(
                  (item) => Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  Text(
                    'المادة: ${item.subCategoryName}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    'السعر: ${item.unitPrice} د.ع ',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    'المجموع: ${item.totalPrice} د.ع ',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(
                    width: 210,
                    child: Divider(color: MyColor.colorGray2, thickness: 0.25),
                  ),

                ],
              ),
            ), SizedBox(
              width: 180,
              child: Center(
                child: Text(
                  'المجموع : ${items.totalAmount.toNumber()} د.ع ',
                  style: TextStyle(fontSize: 10),
                ),
              ),

            ),            SizedBox(height: 10,),  SizedBox(width: 170, child: Align(alignment: Alignment.centerRight,child: Text(items.cashierName.toString(),style: TextStyle(fontSize: 10),))),],
          ),
        ),
        pixelRatio: printingPixelRatio,
      );
      await SunmiPrinter.printImage(byte);
      await SunmiPrinter.lineWrap(10);
      SunmiPrinter.printImage(header);
      await SunmiPrinter.printText(
        '**** تذكرة ${model.name} ****',
        style: SunmiTextStyle(align: SunmiPrintAlign.CENTER, bold: true),
      );
      await SunmiPrinter.printImage(table);

      // await SunmiPrinter.printText('*****************************', style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));

      await SunmiPrinter.lineWrap(10);
      await SunmiPrinter.cutPaper();
      await SunmiPrinter.exitTransactionPrint(true);
    } catch (e) {
      print('Print failed: $e');
    }
  }
}
