import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/provider/weather_provider.dart';
import 'package:flutter_application_1/ui/components/day_items.dart';
import 'package:flutter_application_1/ui/theme/app_color.dart';
import 'package:provider/provider.dart';

class WeekDayWidge extends StatelessWidget {
  const WeekDayWidge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        color: AppColor.sevenDaysColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, i){
            return DayItems(
              
              weekday: context.watch<WeatherProvider>().date[i],
              dayIcon: context.watch<WeatherProvider>().setDailyIcons(i),
              dayTemp: context.watch<WeatherProvider>().setDayTemp(i),
            );
          },
          separatorBuilder: (context, i) => const SizedBox(height: 16,),
          itemCount: 7),
    );
  }
}
