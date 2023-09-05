import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/theme/app_color.dart';
import 'package:flutter_application_1/ui/theme/app_style.dart';
import 'package:provider/provider.dart';

import '../../domain/provider/weather_provider.dart';

class CurrentWeatherStatus extends StatelessWidget {
  const CurrentWeatherStatus({super.key});

  @override
  Widget build(BuildContext context) {
     final model = context.watch<WeatherProvider>();
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       Image.network(model.iconData(), ),
      const SizedBox(width: 25,),
      Text(model.getCurrentStatus(), style: AppStyle.fontStyle.copyWith(color: AppColor.dartblueColor, fontSize: 16),),
      
    ],);
  }
}