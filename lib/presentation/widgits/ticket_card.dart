import 'package:flutter/material.dart';
import 'package:hekayaty/app/extensions.dart';
import 'package:hekayaty/presentation/app_resources/color_manager.dart';

import '../../data/model/categories_model/categories_model.dart';

class TicketCard extends StatelessWidget {
  final SubCategories model;
  final bool isSelected;

  const TicketCard({super.key, required this.model, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? MyColor.colorGreen : MyColor.colorPrimary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: MyColor.colorWhite),
        boxShadow: [BoxShadow(color: MyColor.colorBlack2, blurRadius: 5)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(model.name.toString(), style: TextStyle(color: MyColor.colorWhite)),
          Text(model.price.toNumber(), style: TextStyle(color: MyColor.colorWhite)),
        ],
      ),
    );
  }
}