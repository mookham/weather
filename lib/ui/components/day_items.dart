import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/theme/app_color.dart';
import 'package:flutter_application_1/ui/theme/app_style.dart';

class DayItems extends StatelessWidget {
  const DayItems({super.key, required this.weekday, required this.dayIcon, this.dayTemp = 0, this.nightTemp = 0});
  final String weekday, dayIcon;
  final double dayTemp, nightTemp;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            weekday,
            style: AppStyle.fontStyle.copyWith(color: AppColor.dartblueColor),
          ),
        ),
        Image.network(dayIcon, width: 30, height: 30,),
        Expanded(
          flex: 2,
          child: Text(
            '$dayTemp°C',
            style: AppStyle.fontStyle.copyWith(color: AppColor.dartblueColor),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '$nightTemp°C',
            style: AppStyle.fontStyle,
          ),
        )
      ],
    );
  }
}
