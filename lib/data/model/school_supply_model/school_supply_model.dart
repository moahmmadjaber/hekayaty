import 'package:flutter/cupertino.dart';

class SchoolSupplyModel{
  int id;
  TextEditingController name;
  TextEditingController count;
  TextEditingController price;
  ValueNotifier<String> total;

  SchoolSupplyModel({required this.id,required  this.name,required  this.count,required  this.price,required
  this.total});

}