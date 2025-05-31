import 'package:flutter/foundation.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/helpers/sunmi_helper.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';
import 'package:sunmi_printer_plus/core/sunmi/sunmi_printer.dart';

import '../../../data/model/school_supply_model/school_supply_model.dart';

class RestaurantPrinter {
  static Future<void> printRestaurantPrinterInvoice(List<ReceiptModel> items) async {
    try {
      Uint8List byte = await SunmiHelper.getImageFromAsset(
        'assets/images/hakayety_title.png',
      );
      SunmiPrinter.printImage(byte);
      await SunmiPrinter.lineWrap(10);
      await SunmiPrinter.initPrinter();

      await SunmiPrinter.startTransactionPrint(true);

      await SunmiPrinter.setAlignment(SunmiPrintAlign.RIGHT);
      await SunmiPrinter.setAlignment(SunmiPrintAlign.RIGHT);
      await SunmiPrinter.printText(
        '********* فاتورة المطعم *********',
        style: SunmiTextStyle(align: SunmiPrintAlign.CENTER,bold: true),
      );
      await SunmiPrinter.printText(
        'التاريخ: ${DateTime.now().toString().substring(0, 16)}',
        style: SunmiTextStyle(align: SunmiPrintAlign.CENTER,bold: true),
      );
      await SunmiPrinter.printText('-----------------------------',      style: SunmiTextStyle(align: SunmiPrintAlign.CENTER,bold: true),);

      for (var item in items) {
        await SunmiPrinter.setAlignment(SunmiPrintAlign.RIGHT);
        await SunmiPrinter.printText('رقم: ${item.id}',style: SunmiTextStyle(align: SunmiPrintAlign.RIGHT,bold: true));
        await SunmiPrinter.printText('المادة: ${item.name.text}',style: SunmiTextStyle(align: SunmiPrintAlign.RIGHT,bold: true));
        await SunmiPrinter.printText('العدد: ${item.count.text}',style: SunmiTextStyle(align: SunmiPrintAlign.RIGHT,bold: true));
        await SunmiPrinter.printText('السعر: ${item.price.text} د.ع ',style: SunmiTextStyle(align: SunmiPrintAlign.RIGHT,bold: true));
        await SunmiPrinter.printText('المجموع: ${item.total.value} د.ع ',style: SunmiTextStyle(align: SunmiPrintAlign.RIGHT,bold: true));
        await SunmiPrinter.printText('-----------------------------',style: SunmiTextStyle(align: SunmiPrintAlign.RIGHT,bold: true));
      }

      final grandTotal = items.fold<int>(
        0,
            (prev, element) => prev + (int.tryParse(element.total.value) ?? 0),
      );

      await SunmiPrinter.printText(
        'المجموع الكلي: $grandTotal د.ع ',
        style: SunmiTextStyle(align: SunmiPrintAlign.CENTER,bold: true),
      );
      // await SunmiPrinter.printText('*****************************', style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));

      await SunmiPrinter.lineWrap(10);
      await SunmiPrinter.cutPaper();
      await SunmiPrinter.exitTransactionPrint(true);
    } catch (e) {
      print('Print failed: $e');
    }
  }
}