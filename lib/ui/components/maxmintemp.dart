import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/resources/app_icons.dart';
import 'package:flutter_application_1/ui/theme/app_color.dart';
import 'package:flutter_application_1/ui/theme/app_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../domain/provider/weather_provider.dart';

class MaxMinTemp extends StatelessWidget {
  const MaxMinTemp({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(AppIcons.maxTemp, color: AppColor.redColor,),
        const SizedBox(width: 4,),
        Text('${model.setMaxTemp()}°C', style: AppStyle.fontStyle.copyWith(fontSize: 25, color: AppColor.dartblueColor),),
        const SizedBox(width: 65,),
         SvgPicture.asset(AppIcons.minTemp, color: AppColor.dartblueColor,),
         const SizedBox(width: 4,),
        Text('${model.setMinTemp()}°C', style: AppStyle.fontStyle.copyWith(fontSize: 25, color: AppColor.dartblueColor),),
      ],
    );
  }
}