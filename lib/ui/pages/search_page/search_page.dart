import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/provider/weather_provider.dart';
import 'package:flutter_application_1/ui/components/favorite_list.dart';
import 'package:flutter_application_1/ui/theme/app_color.dart';
import 'package:flutter_application_1/ui/theme/app_style.dart';
import 'package:provider/provider.dart';

import '../../components/current_region_item.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SizedBox(
          width: 312,
          height: 35,
          child: TextField(
            controller: model.searchController,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              fillColor: const Color(0xffc4c4c4),
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(4)),
              hintText: 'Enter city/region',
              hintStyle: AppStyle.fontStyle.copyWith(
                  fontSize: 14, color: AppColor.blackColor.withOpacity(0.5)),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              model.setCurrentCity(context);
            },
            icon: Icon(
              Icons.search,
              color: AppColor.dartblueColor,
            ),
          ),
        ],
      ),
      body: WeatherSearchBody(
        model: model,
      ),
    );
  }
}

class WeatherSearchBody extends StatelessWidget {
  const WeatherSearchBody({super.key, required this.model});
  final WeatherProvider model;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            model.setBg(),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 120, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CurrentRegionItem(),
            const SizedBox(
              height: 28,
            ),
            Text(
              'Special',
              style: AppStyle.fontStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColor.dartblueColor),
            ),
            const SizedBox(
              height: 16,
            ),
            const Expanded(child: FavoriteList(),),
          ],
        ),
      ),
    );
  }
}
