import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/provider/weather_provider.dart';
import 'package:flutter_application_1/ui/theme/app_color.dart';
import 'package:flutter_application_1/ui/theme/app_style.dart';
import 'package:provider/provider.dart';

class CurrentRegionItem extends StatelessWidget {
  const CurrentRegionItem({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              model.setBg(),
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CurrentTimeZone(
              currentCity: model.currentCity,
              currentZone: model.weatherData?.timezone,
            ),
            CurrentRegionTemp(
              icon: model.iconData(),
              currentTemp: model.setCurrentTemp(),
              
            )
          ],
        ),
      ),
    );
  }
}

class CurrentTimeZone extends StatelessWidget {
  const CurrentTimeZone(
      {super.key, required this.currentCity, required this.currentZone});
  final String? currentCity, currentZone;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current place',
          style: AppStyle.fontStyle
              .copyWith(color: AppColor.blueColor, fontSize: 12),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(currentCity ?? 'Error', style: AppStyle.fontStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w700, color: AppColor.blackColor),),
        const SizedBox(
          height: 6,
        ),
        Text(currentZone ?? 'Error', style: AppStyle.fontStyle.copyWith(fontSize: 14, color: AppColor.blackColor),),
      ],
    );
  }
}


class  CurrentRegionTemp extends StatelessWidget {
  const  CurrentRegionTemp({super.key, required this.currentTemp, required this.icon});
 final String icon;
 final int currentTemp;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(icon),
        Text('$currentTemp C', style: AppStyle.fontStyle.copyWith(fontSize: 18, color: AppColor.blackColor),)
      ],
    );
  }
}