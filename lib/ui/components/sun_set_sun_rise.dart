import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/provider/weather_provider.dart';
import 'package:flutter_application_1/ui/resources/app_icons.dart';
import 'package:flutter_application_1/ui/theme/app_color.dart';
import 'package:flutter_application_1/ui/theme/app_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SunsetSunRise extends StatelessWidget {
  const SunsetSunRise({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColor.sevenDaysColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(5),
        
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        RowItemWidget(icon: AppIcons.sunrise, text: 'Sunrise ${model.setCurrentSunRise()}',),
        RowItemWidget(icon: AppIcons.sunset, text: 'Sunset ${model.setCurrentSunSet()}',),
      ],)
    );
  }
}

class RowItemWidget extends StatelessWidget {
  const RowItemWidget({super.key, required this.icon, required this.text});
  final String icon, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(icon, color: AppColor.dartblueColor,),
        const SizedBox(height: 20,),
        Text(text, style: AppStyle.fontStyle.copyWith( fontSize: 16),),
      ],
    );
  }
}