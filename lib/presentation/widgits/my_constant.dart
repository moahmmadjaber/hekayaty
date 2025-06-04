
import 'package:flutter/material.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_skeleton/loader_skeleton.dart';
import 'package:lottie/lottie.dart';

import 'dart:ui' as ui;

import '../../app/di.dart';
import '../app_resources/color_manager.dart';
import '../app_resources/enum_manager.dart';
import 'custom_indicator.dart';

void showToast(txt, ToastType type) {
  switch (type) {
    case ToastType.load:
      EasyLoading.instance
        ..indicatorType = EasyLoadingIndicatorType.cubeGrid
        ..loadingStyle = EasyLoadingStyle.dark
        ..indicatorSize = 45.0
        ..radius = 10.0
        ..backgroundColor = Colors.black54
        ..indicatorColor = Colors.white54
        ..textStyle =
            TextStyle(color: Colors.white70, fontFamily: 'dinn')
        ..maskColor = Colors.black54.withOpacity(0.6)
        ..userInteractions = false
        ..dismissOnTap = false
        ..customAnimation = CustomIndicator();
      EasyLoading.show(status: txt, maskType: EasyLoadingMaskType.custom);
      break;
    case ToastType.success:
      EasyLoading.instance
        ..loadingStyle = EasyLoadingStyle.custom
        ..indicatorSize = 45.0
        ..radius = 10.0
        ..backgroundColor = Colors.black54
        ..indicatorColor = Colors.green
        ..textColor = Colors.green
        ..maskColor = Colors.black54.withOpacity(0.6)
        ..userInteractions = false
        ..dismissOnTap = false
        ..customAnimation = CustomIndicator();
      EasyLoading.showSuccess(txt, maskType: EasyLoadingMaskType.custom);
      break;
    case ToastType.error:
      EasyLoading.instance
        ..loadingStyle = EasyLoadingStyle.custom
        ..indicatorSize = 45.0
        ..radius = 10.0
        ..displayDuration = const Duration(seconds: 3)
        ..backgroundColor = Colors.black54
        ..indicatorColor = Colors.redAccent
        ..textColor = Colors.redAccent
        ..maskColor = Colors.black54.withOpacity(0.6)
        ..userInteractions = false
        ..dismissOnTap = false
        ..customAnimation = CustomIndicator();
      EasyLoading.showError(txt, maskType: EasyLoadingMaskType.custom);
      break;
    case ToastType.info:
      EasyLoading.instance
        ..loadingStyle = EasyLoadingStyle.custom
        ..indicatorSize = 45.0
        ..radius = 10.0
        ..backgroundColor = Colors.black54
        ..indicatorColor = Colors.yellowAccent
        ..textColor = Colors.yellowAccent
        ..maskColor = Colors.black54.withOpacity(0.6)
        ..userInteractions = false
        ..dismissOnTap = false
        ..customAnimation = CustomIndicator();

      EasyLoading.showInfo(txt, maskType: EasyLoadingMaskType.custom);
      break;
    case ToastType.toast:
      EasyLoading.instance
        ..loadingStyle = EasyLoadingStyle.custom
        ..indicatorSize = 45.0
        ..radius = 10.0
        ..backgroundColor = Colors.black54
        ..indicatorColor = Colors.white70
        ..textColor = Colors.white70
        ..maskColor = Colors.black54.withOpacity(0.6)
        ..userInteractions = false
        ..dismissOnTap = false
        ..customAnimation = CustomIndicator();
      EasyLoading.showToast(txt, maskType: EasyLoadingMaskType.custom);
      break;
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
        color: darkTheme?MyColor.darkColor:MyColor.lowGray,
        width: double.infinity,
        child: ListView.builder(itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return darkTheme? DarkCardSkeleton(
              isCircularImage: true,
              isBottomLinesActive: true,
            ):CardSkeleton(
              isCircularImage: true,
              isBottomLinesActive: true,
            ); },
        ));
  }
}


Widget failed(callBack) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Lottie.asset(
        "assets/json/error.json",
      ),
       Text(
        "حدث خطأ",
        style: TextStyle(
            fontFamily: 'dinn', color:darkTheme?MyColor.colorWhite: MyColor.colorRed, fontSize: 20),
      ),
      Center(
        child: TextButton.icon(
          // <-- TextButton
          onPressed: callBack,
          icon:  Icon(
            Icons.refresh,
            size: 28.0,
            color: MyColor.colorPrimary,
          ),
          label:  Text(
            "محاولة مرة اخرى",
            style: TextStyle(
                fontFamily: 'dinn', color: MyColor.colorPrimary, fontSize: 22),
          ),
        ),
      )
    ],
  );
}
Widget paymentFailed(String message) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Lottie.asset(
        "assets/json/error.json",
      ),
      Text(
        message,
        style: TextStyle(
            fontFamily: 'dinn', color:darkTheme?MyColor.colorWhite: MyColor.colorRed, fontSize: 20),
      ),

    ],
  );
}

Widget noData() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Lottie.asset(
        darkTheme?'assets/json/black_no_data.json':"assets/json/nodata.json",
        width: double.infinity,
      ),
      Center(
        child:  Text(
          "لا يوجد بيانات",
          style: TextStyle(
              fontFamily: 'dinn', color:darkTheme?MyColor.colorWhite: MyColor.colorPrimary, fontSize: 22),
        ),
      )
    ],
  );
}

Widget noConversations(String text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Lottie.asset(
        "assets/json/no-conversations.json",
        width: double.infinity,
      ),
      Center(
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'dinn', color:darkTheme?MyColor.colorWhite: MyColor.colorPrimary, fontSize: 22),
        ),
      )
    ],
  );
}







// class LoadingPost extends StatelessWidget {
//   const LoadingPost({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: ui.TextDirection.ltr,
//       child: Container(
//           color: MyColor.colorWhite,
//           width: double.infinity,
//           child: ListView(
//             physics: NeverScrollableScrollPhysics(),
//             children: List.generate(
//                 10,
//                 (e) => Container(
//                     decoration: BoxDecoration(
//                         color: MyColor.accountColor,
//                         border: Border(
//                             bottom: BorderSide(color: MyColor.colorGray2))),
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: 20,
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(right: 10, left: 10),
//                             child: Shimmer.fromColors(
//                                 baseColor: Colors.grey.shade300,
//                                 highlightColor: MyColor.colorWhite,
//                                 child: Container(
//                                   color: Colors.grey.shade300,
//                                   width: double.maxFinite,
//                                   margin: EdgeInsets.only(left: 100),
//                                   height: 15,
//                                 )),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Shimmer.fromColors(
//                             baseColor: Colors.grey.shade300,
//                             highlightColor: MyColor.colorWhite,
//                             child: Container(
//                               padding: EdgeInsets.only(left: 5, right: 5),
//                               margin: EdgeInsets.only(top: 10, bottom: 10),
//                               child: Container(
//                                 color: Colors.grey.shade300,
//                                 width: 100,
//                                 height: 10,
//                               ),
//                             ),
//                           ),
//                           Shimmer.fromColors(
//                               baseColor: Colors.grey.shade300,
//                               highlightColor: MyColor.colorWhite,
//                               child: AspectRatio(
//                                 aspectRatio: 1 / 1,
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       color: Colors.transparent,
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(5)),
//                                       border: Border.all(
//                                           color: Colors.grey.shade300)),
//                                   child: SvgPicture.string(
//                                     outline,
//                                     width: 100,
//                                     fit: BoxFit.fitWidth,
//                                   ),
//                                 ),
//                               )),
//                           Padding(
//                             padding: const EdgeInsets.only(
//                                 right: 15, left: 15, top: 10, bottom: 10),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Shimmer.fromColors(
//                                   baseColor: Colors.grey.shade300,
//                                   highlightColor: MyColor.colorWhite,
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 5),
//                                     child: Icon(
//                                       FontAwesomeIcons.eye,
//                                     ),
//                                   ),
//                                 ),
//                                 Shimmer.fromColors(
//                                   baseColor: Colors.grey.shade300,
//                                   highlightColor: MyColor.colorWhite,
//                                   child: Icon(
//                                     FontAwesomeIcons.share,
//                                   ),
//                                 ),
//                                 Shimmer.fromColors(
//                                   baseColor: Colors.grey.shade300,
//                                   highlightColor: MyColor.colorWhite,
//                                   child: Icon(
//                                     FontAwesomeIcons.comment,
//                                   ),
//                                 ),
//                                 Shimmer.fromColors(
//                                   baseColor: Colors.grey.shade300,
//                                   highlightColor: MyColor.colorWhite,
//                                   child: Icon(
//                                     Icons.thumb_up_alt,
//                                     color: MyColor.colorGray2,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ]))),
//           )),
//     );
//   }
// }

// class DonorsLoading extends StatelessWidget {
//   const DonorsLoading({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: double.maxFinite,
//           padding: EdgeInsets.all(10),
//           margin: EdgeInsets.symmetric(vertical: 10),
//           decoration: BoxDecoration(
//             color: MyColor.colorGray,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Shimmer.fromColors(
//                 baseColor: MyColor.shimmerGray,
//                 highlightColor: MyColor.colorWhite,
//                 child: Text(
//                   AppStrings.name.tr() + ' : ',
//                   style: const TextStyle(
//                     fontFamily: AppStrings.font,
//                     color: MyColor.colorBlack,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Shimmer.fromColors(
//                 baseColor: MyColor.shimmerGray,
//                 highlightColor: MyColor.colorWhite,
//                 child: Text(
//                   AppStrings.phoneNumber.tr() + ' : ',
//                   style: const TextStyle(
//                     fontFamily: AppStrings.font,
//                     color: MyColor.colorBlack,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Shimmer.fromColors(
//                 baseColor: MyColor.shimmerGray,
//                 highlightColor: MyColor.colorWhite,
//                 child: Text(
//                   AppStrings.beneficentNo.tr() + ' : ',
//                   style: TextStyle(
//                       fontFamily: AppStrings.font,
//                       fontSize: 16,
//                       color: MyColor.colorBlack,
//                       fontWeight: FontWeight.bold),
//                 ),
//               )
//             ],
//           ),
//         ),
//         Container(
//           width: double.maxFinite,
//           color: MyColor.colorGray,
//           padding: EdgeInsets.all(10),
//           margin: EdgeInsets.symmetric(vertical: 10),
//           child: Shimmer.fromColors(
//             baseColor: MyColor.shimmerGray,
//             highlightColor: MyColor.colorWhite,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   AppStrings.startDate.tr() + ' : ',
//                   style: TextStyle(
//                       fontFamily: AppStrings.font,
//                       fontSize: 16,
//                       color: MyColor.colorBlack,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Container(
//           width: double.maxFinite,
//           color: MyColor.colorGray,
//           padding: EdgeInsets.all(10),
//           margin: EdgeInsets.symmetric(vertical: 10),
//           child: Shimmer.fromColors(
//             baseColor: MyColor.shimmerGray,
//             highlightColor: MyColor.colorWhite,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       AppStrings.country.tr() + ' : ',
//                       style: TextStyle(
//                           fontFamily: AppStrings.font,
//                           fontSize: 16,
//                           color: MyColor.colorBlack,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       AppStrings.governorate.tr() + ' : ',
//                       style: TextStyle(
//                           fontFamily: AppStrings.font,
//                           fontSize: 16,
//                           color: MyColor.colorBlack,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       AppStrings.branch.tr() + ' : ',
//                       style: TextStyle(
//                           fontFamily: AppStrings.font,
//                           fontSize: 16,
//                           color: MyColor.colorBlack,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       AppStrings.office.tr() + ' : ',
//                       style: TextStyle(
//                           fontFamily: AppStrings.font,
//                           fontSize: 16,
//                           color: MyColor.colorBlack,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 Center(
//                   child: Shimmer.fromColors(
//                       child: SvgPicture.string(
//                         outline,
//                         height: 100,
//                         fit: BoxFit.fitHeight,
//                       ),
//                       baseColor: MyColor.shimmerGray,
//                       highlightColor: MyColor.colorWhite),
//                 )
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

// class DonationLoading extends StatelessWidget {
//   const DonationLoading({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           margin: EdgeInsets.only(bottom: 10),
//           padding: EdgeInsets.only(top: 10, bottom: 10),
//           width: double.maxFinite,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   bottomRight: Radius.circular(7),
//                   bottomLeft: Radius.circular(7)),
//               color: MyColor.colorPrimary,
//               boxShadow: [
//                 BoxShadow(
//                     color: MyColor.colorGray2.withOpacity(0.7),
//                     offset: Offset(0, 1),
//                     blurRadius: 2),
//                 BoxShadow(
//                     color: MyColor.colorGray2.withOpacity(0.7),
//                     offset: Offset(0, -1),
//                     blurRadius: 2)
//               ]),
//           child: Shimmer.fromColors(
//             baseColor: MyColor.colorWhite,
//             highlightColor: MyColor.colorBlack2,
//             direction: ShimmerDirection.rtl,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   textAlign: TextAlign.center,
//                   AppStrings.totalAmountDon,
//                   style: TextStyle(
//                       fontFamily: AppStrings.font,
//                       color: MyColor.colorWhite,
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold),
//                 ).tr(),
//                 Text(
//                   textAlign: TextAlign.center,
//                   '...',
//                   style: TextStyle(
//                       fontFamily: AppStrings.font,
//                       color: MyColor.colorWhite,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 )
//               ],
//             ),
//           ),
//         ),
//         Expanded(
//           child: ListView(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             children: List.generate(
//                 10,
//                 (s) => Container(
//                       padding: EdgeInsets.all(5),
//                       width: double.maxFinite,
//                       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//                       decoration: BoxDecoration(
//                           color: MyColor.accountColor,
//                           border: Border.all(color: MyColor.colorBlack3),
//                           borderRadius: BorderRadius.all(Radius.circular(10))),
//                       child: Shimmer.fromColors(
//                         baseColor: MyColor.accountColor,
//                         highlightColor: MyColor.colorBlack3,
//                         direction: ShimmerDirection.rtl,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   AppStrings.invoiceNo.tr() + '  : ',
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold,
//                                       color: MyColor.colorBlack,
//                                       fontFamily: 'dinn'),
//                                 ),
//                                 Text(
//                                   AppStrings.invoiceDate.tr() + '  : ',
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold,
//                                       color: MyColor.colorBlack,
//                                       fontFamily: 'dinn'),
//                                 ),
//                                 Text(
//                                   AppStrings.invoiceAmount.tr() + '  : ',
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold,
//                                       color: MyColor.colorBlack,
//                                       fontFamily: 'dinn'),
//                                 ),
//                                 Text(
//                                   AppStrings.invoiceType.tr() + '  : ',
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold,
//                                       color: MyColor.colorBlack,
//                                       fontFamily: 'dinn'),
//                                 ),
//                               ],
//                             ),
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Image.asset(
//                                 'assets/images/invoice.png',
//                                 width: 60,
//                                 fit: BoxFit.fitWidth,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     )),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class DeliveredBoxesLoading extends StatelessWidget {
//   const DeliveredBoxesLoading({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       physics: NeverScrollableScrollPhysics(),
//       padding: EdgeInsets.only(top: 60),
//       children: List.generate(
//           10,
//           (e) => Opacity(
//                 opacity: 0.5,
//                 child: Container(
//                   margin:
//                       EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
//                   decoration: BoxDecoration(
//                       border: Border.all(color: MyColor.colorGray2),
//                       color: MyColor.accountColor,
//                       borderRadius: BorderRadius.all(Radius.circular(15))),
//                   child: Shimmer.fromColors(
//                     baseColor: MyColor.accountColor,
//                     highlightColor: MyColor.colorBlack2,
//                     child: Stack(
//                       alignment:
//                           isLeft ? Alignment.centerRight : Alignment.centerLeft,
//                       children: [
//                         Padding(
//                           padding: isLeft
//                               ? const EdgeInsets.only(right: 10)
//                               : const EdgeInsets.only(left: 10),
//                           child: Opacity(
//                               opacity: 0.1,
//                               child: Image.asset(
//                                 'assets/images/boxbg.png',
//                                 width: 60,
//                                 fit: BoxFit.fitWidth,
//                               )),
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Flexible(
//                               flex: 2,
//                               fit: FlexFit.tight,
//                               child: Container(
//                                 padding: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                     color: MyColor.colorPrimary,
//                                     border: Border.all(
//                                         width: 1, color: MyColor.colorBlack2),
//                                     borderRadius: isLeft
//                                         ? BorderRadius.only(
//                                             topLeft: Radius.circular(15),
//                                             bottomLeft: Radius.circular(15),
//                                           )
//                                         : BorderRadius.only(
//                                             topRight: Radius.circular(15),
//                                             bottomRight: Radius.circular(15),
//                                           )),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     SvgPicture.asset(
//                                       'assets/svg/box_ico.svg',
//                                       color: MyColor.colorWhite,
//                                       height: 60,
//                                       fit: BoxFit.fitHeight,
//                                     ),
//                                     Text(
//                                       '...',
//                                       style: TextStyle(
//                                           color: MyColor.colorWhite,
//                                           fontFamily: AppStrings.font),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Flexible(
//                               flex: 6,
//                               child: Padding(
//                                 padding: isLeft
//                                     ? const EdgeInsets.only(left: 15)
//                                     : const EdgeInsets.only(right: 15),
//                                 child: Row(
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisSize: MainAxisSize.min,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           "${AppStrings.boxCode.tr()} ",
//                                           style: TextStyle(
//                                               color: MyColor.colorBlack,
//                                               fontFamily: AppStrings.font,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         Text(
//                                           "${AppStrings.boxStatus.tr()} ",
//                                           style: TextStyle(
//                                               color: MyColor.colorBlack,
//                                               fontFamily: AppStrings.font,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         Text(
//                                           "${AppStrings.receiveDate.tr()} ",
//                                           style: TextStyle(
//                                               color: MyColor.colorBlack,
//                                               fontFamily: AppStrings.font,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         Row(
//                                           children: [
//                                             Text(
//                                               "${AppStrings.retrieveDate.tr()} ",
//                                               style: TextStyle(
//                                                   color: MyColor.colorBlack,
//                                                   fontFamily: AppStrings.font,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )),
//     );
//   }
// }

// class CollectedBoxesLoading extends StatelessWidget {
//   const CollectedBoxesLoading({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: EdgeInsets.only(top: 60),
//       physics: NeverScrollableScrollPhysics(),
//       children: List.generate(
//           10,
//           (e) => Padding(
//                 padding:
//                     EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
//                 child: Shimmer.fromColors(
//                   baseColor: MyColor.accountColor,
//                   highlightColor: MyColor.colorBlack2,
//                   child: Stack(
//                     alignment: isLeft ? Alignment.topRight : Alignment.topLeft,
//                     children: [
//                       ListTile(
//                         contentPadding: EdgeInsets.zero,
//                         tileColor: MyColor.accountColor,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(15)),
//                             side: BorderSide(color: MyColor.colorBlack3)),
//                         title: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Flexible(
//                               flex: 2,
//                               fit: FlexFit.tight,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   SvgPicture.asset(
//                                     'assets/svg/box_ico.svg',
//                                     height: 30,
//                                     fit: BoxFit.fitHeight,
//                                   ),
//                                   Padding(
//                                     padding:
//                                         EdgeInsets.symmetric(horizontal: 7),
//                                     child: FittedBox(
//                                       fit: BoxFit.scaleDown,
//                                       child: Text(
//                                         '...',
//                                         style: TextStyle(
//                                           color: MyColor.colorBlack,
//                                           fontFamily: AppStrings.font,
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: 30,
//                               width: 2,
//                               child: VerticalDivider(
//                                 color: MyColor.colorGray2,
//                               ),
//                             ),
//                             Flexible(
//                               fit: FlexFit.tight,
//                               flex: 5,
//                               child: Padding(
//                                 padding: isLeft
//                                     ? const EdgeInsets.only(left: 15)
//                                     : const EdgeInsets.only(right: 15),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisSize: MainAxisSize.min,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     FittedBox(
//                                       fit: BoxFit.scaleDown,
//                                       child: Text(
//                                         "${AppStrings.boxCode.tr()} : ",
//                                         style: TextStyle(
//                                             color: MyColor.colorBlack,
//                                             fontFamily: AppStrings.font,
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                     Text(
//                                       "${AppStrings.boxAmount.tr()} : ",
//                                       style: TextStyle(
//                                           color: MyColor.colorBlack,
//                                           fontFamily: AppStrings.font,
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     Text(
//                                       "${AppStrings.openDate.tr()} : ",
//                                       style: TextStyle(
//                                           color: MyColor.colorBlack,
//                                           fontFamily: AppStrings.font,
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: isLeft
//                             ? const EdgeInsets.only(top: 10, right: 11)
//                             : const EdgeInsets.only(top: 10, left: 11),
//                         child: Opacity(
//                             opacity: 0.1,
//                             child: Image.asset(
//                               'assets/images/boxbg.png',
//                               width: 50,
//                               fit: BoxFit.fitWidth,
//                             )),
//                       ),
//                     ],
//                   ),
//                 ),
//               )),
//     );
//   }
// }

// class TakenBoxesLoading extends StatelessWidget {
//   const TakenBoxesLoading({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       physics: NeverScrollableScrollPhysics(),
//       padding: EdgeInsets.only(top: 60),
//       children: List.generate(
//           10,
//           (e) => Container(
//                 margin: EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
//                 decoration: BoxDecoration(
//                     border: Border.all(color: MyColor.colorGray2),
//                     color: MyColor.accountColor,
//                     borderRadius: BorderRadius.all(Radius.circular(15))),
//                 child: Shimmer.fromColors(baseColor: MyColor.accountColor,highlightColor: MyColor.colorBlack2,
//                   child: Stack(
//                     alignment:
//                         isLeft ? Alignment.centerRight : Alignment.centerLeft,
//                     children: [
//                       Padding(
//                         padding: isLeft
//                             ? const EdgeInsets.only(right: 10)
//                             : const EdgeInsets.only(left: 10),
//                         child: Opacity(
//                             opacity: 0.1,
//                             child: Image.asset(
//                               'assets/images/boxbg.png',
//                               width: 60,
//                               fit: BoxFit.fitWidth,
//                             )),
//                       ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Flexible(
//                             flex: 2,
//                             child: Container(
//                               padding: EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                   color: MyColor.colorPrimary,
//                                   border: Border.all(
//                                       width: 1, color: MyColor.colorBlack2),
//                                   borderRadius: isLeft
//                                       ? BorderRadius.only(
//                                           topLeft: Radius.circular(15),
//                                           bottomLeft: Radius.circular(15),
//                                         )
//                                       : BorderRadius.only(
//                                           topRight: Radius.circular(15),
//                                           bottomRight: Radius.circular(15),
//                                         )),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   SvgPicture.asset(
//                                     'assets/svg/box_ico.svg',
//                                     color: MyColor.colorWhite,
//                                     height: 60,
//                                     fit: BoxFit.fitHeight,
//                                   ),
//                                   Text(
//                                     '.....',
//                                     style: TextStyle(
//                                         color: MyColor.colorWhite,
//                                         fontFamily: AppStrings.font),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Flexible(
//                             flex: 4,
//                             child: Padding(
//                               padding: isLeft
//                                   ? const EdgeInsets.only(left: 15)
//                                   : const EdgeInsets.only(right: 15),
//                               child: Row(
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisSize: MainAxisSize.min,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "${AppStrings.boxCode.tr()}   : ",
//                                         style: TextStyle(
//                                             color: MyColor.colorBlack,
//                                             fontFamily: AppStrings.font,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       Text(
//                                         "${AppStrings.boxStatus.tr()} : ",
//                                         style: TextStyle(
//                                             color: MyColor.colorBlack,
//                                             fontFamily: AppStrings.font,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       Text(
//                                         "${AppStrings.takenDate.tr()}  : ",
//                                         style: TextStyle(
//                                             color: MyColor.colorBlack,
//                                             fontFamily: AppStrings.font,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               )),
//     );
//   }
// }
// class OrphansLoading extends StatelessWidget {
//   const OrphansLoading({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(physics: NeverScrollableScrollPhysics(),children: List.generate(10, (e)=>Container(
//       decoration: BoxDecoration(
//           color: MyColor.colorGray,
//           borderRadius: BorderRadius.all(Radius.circular(5))),
//       margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
//       padding: const EdgeInsets.only( right: 15, left: 15,bottom: 10),
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 8.0),
//             child: Align(alignment: Alignment.centerRight,
//               child: Container(width: MediaQuery.of(context).size.width*0.95,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     //البيانات العامة
//                     Row(
//                       children: [
//                         Text(
//                           '${AppStrings.name.tr()} : ',
//                           style: TextStyle(
//                               fontFamily: AppStrings.font,
//                               fontSize: 16,
//                               color: MyColor.colorBlack,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Container(width: MediaQuery.of(context).size.width*0.72 ,
//                           child: Text(
//                           '...',
//                             style: const TextStyle(
//                                 fontFamily: AppStrings.font,
//                                 fontSize: 14,
//                                 color: MyColor.colorBlack2,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           '${AppStrings.code.tr()} : ',
//                           style: TextStyle(
//                               fontFamily: AppStrings.font,
//                               fontSize: 16,
//                               color: MyColor.colorBlack,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                          '...',
//                           style: const TextStyle(
//                               fontFamily: AppStrings.font,
//                               fontSize: 14,
//                               color: MyColor.colorBlack2,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           '${AppStrings.government.tr()} : ',
//                           style: TextStyle(
//                               fontFamily: AppStrings.font,
//                               fontSize: 16,
//                               color: MyColor.colorBlack,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           widget.model.governmentName.toString(),
//                           style: const TextStyle(
//                               fontFamily: AppStrings.font,
//                               fontSize: 14,
//                               color: MyColor.colorBlack2,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           '${AppStrings.bailType.tr()} : ',
//                           style: TextStyle(
//                               fontFamily: AppStrings.font,
//                               fontSize: 16,
//                               color: MyColor.colorBlack,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           widget.model.sponsorCategoryDescription.toString(),
//                           style: const TextStyle(
//                               fontFamily: AppStrings.font,
//                               fontSize: 14,
//                               color: MyColor.colorBlack2,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     )
//                     ,
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           '${AppStrings.healthStatus.tr()} : ',
//                           style: TextStyle(
//                               fontFamily: AppStrings.font,
//                               fontSize: 16,
//                               color: MyColor.colorBlack,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           widget.model.healthStatusDesc.toString(),
//                           style: const TextStyle(
//                               fontFamily: AppStrings.font,
//                               fontSize: 14,
//                               color: MyColor.colorBlack2,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//
//                     Stack(
//                       children: [
//                         AnimatedContainer(width: 210,
//                           color: MyColor.colorGray,
//                           duration: Duration(milliseconds: 800),
//                           curve: Curves.easeInOut,
//                           child:  FittedBox(
//                             child: const Text(
//                               AppStrings.monthlyPaymentDetails,
//                               style: TextStyle(
//                                   fontFamily: AppStrings.font,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 14,
//                                   color: MyColor.colorPrimary),
//                             ).tr(),
//                           ),
//                           transform: Transform.translate(
//                             offset: Offset(
//                                 0, up ? 30 : 0), // Change -100 for the y offset
//                           ).transform,
//                         ),
//                         Row(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 _toggleAnimation();
//                               },
//                               child: Container(width: 210,
//                                 color: MyColor.colorGray,
//                                 child: Row(mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Text(
//                                       '${AppStrings.monthlyPayment.tr()} : ',
//                                       style: TextStyle(
//                                           fontFamily: AppStrings.font,
//                                           fontSize: 16,
//                                           color: MyColor.colorBlack,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     Text(
//                                       setComma(widget.model.yateemAmount) ??
//                                           'غير معرف' + AppStrings.currency.tr(),
//                                       style: const TextStyle(
//                                           fontFamily: AppStrings.font,
//                                           fontSize: 16,
//                                           color: MyColor.colorBlack2,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//
//                                     AnimatedRotation(
//                                       turns: !up ? 0 :isLeft?-0.08 * pi: 0.08 * pi,
//                                       duration: Duration(milliseconds: 400),
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(top: 5),
//                                         child: RippleAnimation(ripplesCount: 1,repeat: true,color: MyColor.primaryGold.withOpacity(0.5),minRadius: 12,
//                                           child: Padding(
//                                             padding: isLeft?const EdgeInsets.only(left: 5):const EdgeInsets.only(right: 5),
//                                             child: Icon(
//                                               Icons.arrow_back_ios,
//                                               color: MyColor.colorRed,
//                                               size: 15,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//
//
//                     AnimatedPadding(
//                       padding: EdgeInsets.only(top: up ? 25 : 0),
//                       duration: Duration(milliseconds: 800),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(AppStrings.leftForBirthDay.tr(),
//                               style: TextStyle(
//                                 fontFamily: AppStrings.font,
//                                 fontSize: 15,
//                                 color: MyColor.colorBlack,
//                                 fontWeight: FontWeight.bold,
//                               )),
//                           Text(
//                               widget.model.remainDays.toString() ,
//                               style: TextStyle(
//                                 fontFamily: AppStrings.font,
//                                 fontSize: 15,
//                                 color: MyColor.colorBlack2,
//                                 fontWeight: FontWeight.bold,
//                               )),
//                           LottieBuilder.asset(
//                             'assets/json/sand_clock.json',
//                             width: 25,
//                             fit: BoxFit.fitWidth,
//                           ),
//                         ],
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Row(mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [Padding(
//                   padding: const EdgeInsets.only(top: 50),
//                   child: ClipRRect(borderRadius:BorderRadius.all(Radius.circular(15)),
//                     child: widget.model.genderDesc=='ذكر'?
//                     SvgPicture.asset(
//                       'assets/svg/boy.svg',
//                       width: 70,
//                       fit: BoxFit.fitWidth,
//                     )
//                         :                    SvgPicture.asset(
//                       'assets/svg/girl.svg',
//                       width: 70,
//                       fit: BoxFit.fitWidth,
//                     ),
//                   ),
//                 )
//                   , Text(
//                     widget.model.genderDesc.toString(),
//                     style: const TextStyle(
//                         fontFamily: AppStrings.font,
//                         fontSize: 14,
//                         color: MyColor.colorBlack2,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     DateTime.parse(widget.model.birthDate.toString())
//                         .toDate(),
//                     style: const TextStyle(
//                         fontFamily: AppStrings.font,
//                         fontSize: 14,
//                         color: MyColor.colorBlack2,
//                         fontWeight: FontWeight.bold),
//                   )
//                 ],
//               ),
//             ],
//           )
//
//         ],
//       ),
//     )),);
//   }
// }

