import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:hekayaty/app/extensions.dart';
import 'package:hekayaty/presentation/app_resources/color_manager.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/helpers/sunmi_helper.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';
import 'package:sunmi_printer_plus/core/sunmi/sunmi_printer.dart';

import '../../../data/model/tickets_model/tickets_model.dart';

class TicketPrinting {
  static printInvoice({
    required BuildContext context,required int discount,
    required String flowerName,
    required String flowerPhone,
    required final List<TicketModel> items,
    final TicketModel? flowerModel,
    required final int childrenCount,
    required final int flowerCount,
  }) async {
    ScreenshotController screenshotController = ScreenshotController();
     int total =(items.fold(0, (previousValue, element) => previousValue + childrenCount * int.parse(element.price)))+(flowerCount * int.parse(flowerModel!.price));;
    try {
      Uint8List byte = await SunmiHelper.getImageFromAsset(
        'assets/images/black_icon.png',
      );
      await SunmiPrinter.printImage(byte);

      await SunmiPrinter.initPrinter();

      screenshotController
          .captureFromWidget(
            context: context,
            Column(mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 200,
                  child: Divider(color: MyColor.colorGray2, thickness: 0.5),
                ),
                Text('رقم الوصل :55555 ', style: TextStyle(fontSize: 10)),
                Text(
                  'تاريخ الوصل: ${DateTime.now().toDate()}',
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        DateTime.now().toTime(),
                        style: TextStyle(fontSize: 10),
                      ),
                      Text('وقت الوصل: ', style: TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Divider(color: MyColor.colorGray2, thickness: 0.25),
                ),
                Text(
                  ' اسم المرافق : $flowerName',
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  ' رقم الهاتف : $flowerPhone',
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(
                  width: 200,
                  child: Divider(color: MyColor.colorGray2, thickness: 0.25),
                ),

              ],
            ),
          )
          .then((item) async {
            await SunmiPrinter.printImage(item);
          });
      screenshotController
          .captureFromWidget(
            context: context,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ItemsWidget(
                  items: items,
                  flowerModel: flowerModel,
                  childrenCount: childrenCount,
                  flowerCount: flowerCount,
                ),
                SizedBox(
                  width: 180,
                  child: Center(
                    child: Text(
                      'المجموع قبل الخصم: $total د.ع ',style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: Center(
                    child: Text(
                      'المجموع بعد الخصم: ${total - (total * discount / 100)} د.ع ',style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
          )
          .then((item) async {
            await SunmiPrinter.printImage(item);
            await SunmiPrinter.lineWrap(100);
          });

      // await SunmiPrinter.printText('*****************************', style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));

      await SunmiPrinter.cutPaper();
      await SunmiPrinter.exitTransactionPrint(true);
    } catch (e) {
      print('Print failed: $e');
    }
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
    final rows =
        items.map<DataRow>((s) {
          final total = childrenCount * int.parse(s.price);
          return DataRow(
            cells: [
              DataCell(
                SizedBox(
                  width: 50,
                  child: Text(
                    total.toString(),
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 40,
                  child: Text(
                    s.price,
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 25,
                  child: Text(
                    childrenCount.toString(),
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 100,
                  child: Text(
                    s.name,
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          );
        }).toList();

    if (flowerModel != null) {
      final flowerTotal = flowerCount * int.parse(flowerModel!.price);
      rows.add(
        DataRow(
          cells: [
            DataCell(
              SizedBox(
                width: 50,
                child: Text(
                  flowerTotal.toString(),
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            DataCell(
              SizedBox(
                width: 40,
                child: Text(
                  flowerModel!.price,
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            DataCell(
              SizedBox(
                width: 25,
                child: Text(
                  flowerCount.toString(),
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            DataCell(
              SizedBox(
                width: 100,
                child: Text(
                  flowerModel!.name,
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
    }

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
