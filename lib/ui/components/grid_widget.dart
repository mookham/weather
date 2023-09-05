import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/provider/weather_provider.dart';
import 'package:flutter_application_1/ui/resources/app_icons.dart';
import 'package:flutter_application_1/ui/theme/app_color.dart';
import 'package:flutter_application_1/ui/theme/app_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class GridWidget extends StatelessWidget {
  const GridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return SizedBox(
      height: 340,
     
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 20, crossAxisSpacing: 20, crossAxisCount: 2, mainAxisExtent: 160),
          itemBuilder: (context, i) {
            return SizedBox(
              child: Card(
                color: AppColor.sevenDaysColor.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: ListTile(
                    leading: SvgPicture.asset(GridIcons.gridIcons[i]),
                    title: Text('${model.setValues(i)} ${GridIcons.gridunits[i]}', style: AppStyle.fontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w700),),
                    subtitle: Text(GridIcons.gridDescribtion[i], style: AppStyle.fontStyle.copyWith(fontSize: 10, color: AppColor.dartblueColor),),
                  ),
                ),
                
              ),
            );
          }),
    );
  }
}

class GridIcons{
  static List<String> gridIcons = [
    AppIcons.windSpeed,
    AppIcons.thermometer,
    AppIcons.rainDrops,
    AppIcons.glasses,
  ];
   static List<String> gridunits = [
    'km/h',
    '°',
    '%',
    'km',
  ];
  static List<String> gridDescribtion = [
    'Wild speed',
    'Feel',
    'Humit',
    'Visibility',
  ];
   
}
