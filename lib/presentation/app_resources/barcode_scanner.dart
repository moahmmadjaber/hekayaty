// import 'package:flutter/material.dart';
// import 'package:hekayaty/presentation/app_resources/color_manager.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:sunmi_scanner/sunmi_scanner.dart';
//
// class BarcodeScannerPage extends StatefulWidget {
//   const BarcodeScannerPage({super.key});
//
//   @override
//   State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
// }
//
// class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
//   final MobileScannerController _controller = MobileScannerController();
//   bool _isScanned = false;
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//   @override
//   void initState() {
//     SunmiScanner.stop();
//     super.initState();
//   }
//
//   void _handleBarcodeScan(BarcodeCapture capture) {
//     if (_isScanned) return;
//
//     final barcode = capture.barcodes.first;
//     final String? code = barcode.rawValue;
//
//     if (code != null) {
//       setState(() {
//         _isScanned = true;
//       });
//
//       _controller.stop(); // Pause the scanner
//
//       Navigator.of(context).pop(code);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(iconTheme: IconThemeData(color: MyColor.colorWhite),title: const Text("الرمز الشريطي",style: TextStyle(fontSize: 20,color: MyColor.colorWhite),)),
//       body: MobileScanner(
//         controller: _controller,
//         onDetect: _handleBarcodeScan,
//       ),
//     );
//   }
// }
