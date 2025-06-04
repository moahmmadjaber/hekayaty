
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';


import 'di.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return "";
    } else {
      return this!;
    }
  }
  String cut(int end){
    if (this == null) {
      return "";
    } else {
      if(this!.length<=end){
        return this!;
      }else {
        return this!.substring(0, end) + '...';
      }
    }
  }
}

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
  String  toNumber(){
    if(this==null){
      return '0';
    }
    else
    return NumberFormat("###,###,###", "en_US").format(this);
  }
}
extension doubleParsing on double?{
  String  toNumber(){
    if(this==null){
      return '0';
    }
    else
      return NumberFormat("###,###,###", "en_US").format(this);
  }
}

extension FormatDate on DateTime? {
  int countSeconds(){
    if(this==null){
      return 0;
    }
    else{
      return (this!.hour*360)+(this!.minute*60)+this!.second;
    }
  }
  String toFormat() {
    if (this == null) {
      return isLeft?'unknown':'غير معرف';
    }else {
      final DateFormat formatter = DateFormat('yyyy/MM/dd - hh:mm','en-sa');
      return formatter.format(this!);
    }
  }
  String postsFormat() {
    if (this == null) {
      return isLeft?'unknown':'غير معرف';
    }else {
      final DateFormat formatter = DateFormat('yyyy/MM/dd - a hh:mm','en-sa');
      return formatter.format(this!);
    }
  }


  String timeFormat() {
    if (this == null) {
      return isLeft?'unknown':'غير معرف';
    }else {
      final DateFormat formatter = DateFormat('hh:mm','en-sa');
      return formatter.format(this!.add(Duration(hours: 3)));
    }
  }
  String amPm(){
    return DateFormat('a','en-sa').format(this!.add(Duration(hours: 3)));
  }
  String fullDate() {
    if (this == null) {
      return isLeft?'unknown':'غير معرف';
    }else {
      return DateFormat('hh:mma - yyyy/MM/dd','en-iq').format(this!.add(Duration(hours: 3))!);
    }
  }
  String toDate() {
    if (this == null) {
      return isLeft?'unknown':'غير معرف';
    }else {
      final DateFormat formatter = DateFormat('yyyy/MM/dd','en-us');
      return formatter.format(this!);
    }
  }
  String toYear() {
    if (this == null) {
      return isLeft?'unknown':'غير معرف';
    }else {
      final DateFormat formatter = DateFormat('yyyy','en-us');
      return formatter.format(this!);
    }
  }
  String toDateName() {
    if (this == null) {
      return isLeft?'unknown':'غير معرف';
    }else {
      final DateFormat formatter = DateFormat('yyyy-MM-dd','en-us');
      return formatter.format(this!);
    }
  }
  String toTime() {
    if (this == null) {
      return isLeft?'unknown':'غير معرف';
    }else {
      final DateFormat formatter = DateFormat('hh:mma','en_us');
      return formatter.format(this!);
    }
  }
  String toCallTime() {
    if (this == null) {
      return isLeft?'unknown':'غير معرف';
    }else {
      final DateFormat formatter = DateFormat('mm : ss','en_us');
      return formatter.format(this!);
    }
  }

}
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
extension durationString on Duration{
  String toTime(){
    return '$inHours : $inMinutes : $inSeconds';
  }
}
