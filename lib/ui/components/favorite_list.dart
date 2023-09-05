import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/hive/favorite_history.dart';
import 'package:flutter_application_1/domain/provider/weather_provider.dart';
import 'package:flutter_application_1/ui/components/current_region_item.dart';
import 'package:flutter_application_1/ui/resources/app_bg.dart';
import 'package:flutter_application_1/ui/theme/app_color.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../domain/hive/hive_boxs.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
          valueListenable:
              Hive.box<FavoriteHistory>(HiveBoxs.favoriteBox).listenable(),
          builder: (context, value, _) {
            return ListView.separated(
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, i) {
                  return FavoriteCard(
                    index: i,
                    value: value,
                  );
                },
                separatorBuilder: (context, i) => const SizedBox(
                      height: 10,
                    ),
                itemCount: value.length);
          }),
    );
  }
}

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key, required this.index, required this.value});
  final int index;
  final Box<FavoriteHistory> value;
  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(value.getAt(index)?.bg ?? AppBg.fogDay))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CurrentTimeZone(
              currentCity: value.getAt(index)?.currentCity ?? 'Error',
              currentZone: model.weatherData?.timezone),
          CurrentRegionTemp(
              currentTemp: model.setCurrentTemp(), icon: model.iconData()),
          IconButton(
              onPressed: () {
                model.deleteFavorite(index);
              },
              icon: Icon(
                Icons.close,
                color: AppColor.redColor,
              )),
        ],
      ),
    );
  }
}
