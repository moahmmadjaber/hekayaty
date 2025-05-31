import 'package:flutter/cupertino.dart';

class ReceiptModel{
  int id;
  TextEditingController name;
  TextEditingController count;
  TextEditingController price;
  ValueNotifier<String> total;

  ReceiptModel({required this.id,required  this.name,required  this.count,required  this.price,required
  this.total});

}