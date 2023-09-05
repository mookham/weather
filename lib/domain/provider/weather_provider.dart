import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/api/api.dart';
import 'package:flutter_application_1/domain/hive/favorite_history.dart';
import 'package:flutter_application_1/domain/hive/hive_boxs.dart';
import 'package:flutter_application_1/domain/models/weather_model.dart';
import 'package:flutter_application_1/ui/theme/app_color.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ui/resources/app_bg.dart';
import '../models/coord.dart';

class WeatherProvider extends ChangeNotifier {
  Coord? coords;
  WeatherData? weatherData;
  Current? current;
  final searchController = TextEditingController();
  final pref = SharedPreferences.getInstance();
  String currentCity = 'Tashkent';
  
  
  Future<WeatherData?> setUp({String? cityName}) async {
    
    cityName =(await pref).getString('city');
    
    coords = await Api.getCoords(cityName: cityName ?? currentCity);
    weatherData = await Api.getWeather(coords);
    current = weatherData?.current;
    setCurrentTime();
    setCurrentTemp();
    setSevenDays();
    getCurrentCity();
 
    return weatherData;
  }
  
  Future<String> getCurrentCity()async{
    currentCity = (await pref).getString('city') ??  currentCity;
    return currentCity;
  }
  
  


  String? currentBg;
  String setBg() {
    int id = current?.weather?[0].id ?? -1;
    if (id == -1 || current?.sunset == null || current?.dt == null) {
      currentBg = AppBg.shinyDay;
    }
    try {
      if (current?.sunset < current?.dt) {
        if (id >= 200 && id <= 531) {
          currentBg = AppBg.rainyNight;
          AppColor.dartblueColor = AppColor.whiteColor;
        } else if (id >= 600 && id <= 622) {
          currentBg = AppBg.snowNight;
          AppColor.dartblueColor = AppColor.whiteColor;
        } else if (id >= 701 && id <= 781) {
          currentBg = AppBg.fogNight;
          AppColor.dartblueColor = AppColor.whiteColor;
        } else if (id == 800) {
          currentBg = AppBg.shinyNight;
          AppColor.dartblueColor = AppColor.whiteColor;
        } else if (id >= 801 && id <= 804) {
          currentBg = AppBg.cloudyNight;
          AppColor.dartblueColor = AppColor.whiteColor;
        }
      } else {
        if (id >= 200 && id <= 531) {
          currentBg = AppBg.rainyDay;
        } else if (id >= 600 && id <= 622) {
          currentBg = AppBg.snowDay;
        } else if (id >= 701 && id <= 781) {
          currentBg = AppBg.fogDay;
        } else if (id == 800) {
          currentBg = AppBg.shinyDay;
          AppColor.shinyColor = const Color(0xffeb3f4f);
        } else if (id >= 801 && id <= 804) {
          currentBg = AppBg.cloudyDay;
        }
      }
    } catch (e) {
      return AppBg.shinyDay;
    }
    return currentBg ?? AppBg.shinyDay;
  }

  String? currentTime;
  String setCurrentTime() {
    final getTime = (current?.dt ?? 0) + (weatherData?.timezoneOffset ?? 0);
    final setTime = DateTime.fromMillisecondsSinceEpoch(getTime * 1000);
    currentTime = DateFormat('HH:mm a').format(setTime);
    return currentTime ?? 'Error';
  }

  String currentStatus = '';
  String getCurrentStatus() {
    currentStatus = current?.weather?[0].description ?? 'Error';
    return capitalize(currentStatus);
  }

  String capitalize(String str) => str[0].toUpperCase() + str.substring(1);
  final String _iconUrlPath = 'https://openweathermap.org/img/wn/';
  String iconData() {
    return '$_iconUrlPath${current?.weather?[0].icon}.png';
  }

  int kelvin = -273;
  int currentTemp = 0;
  int setCurrentTemp() {
    currentTemp = ((current?.temp ?? -kelvin) + kelvin).round();
    return currentTemp;
  }

  double maxTemp = 0;
  double setMaxTemp() {
    maxTemp = ((weatherData?.daily?[0].temp?.max ?? -kelvin) + kelvin)
        .roundToDouble();
    return maxTemp;
  }

  double minTemp = 0;
  double setMinTemp() {
    minTemp = ((weatherData?.daily?[0].temp?.min ?? -kelvin) + kelvin)
        .roundToDouble();
    return minTemp;
  }

  final List<String> date = [];
  List<Daily> daily = [];

  void setSevenDays() {
    daily = weatherData!.daily!;
    for (var i = 0; i < daily.length; i++) {
      if (i == 0 && daily.isNotEmpty) {
        date.clear();
      }

      if (i == 0) {
        date.add('today');
      } else {
        var timeNum = daily[i].dt * 1000;
        var itemdate = DateTime.fromMillisecondsSinceEpoch(timeNum);
        date.add(capitalize(DateFormat(
          'EEEE',
        ).format(itemdate)));
      }
    }
  }

  String setDailyIcons(int index) {
    final String getIcon = '${weatherData?.daily?[index].weather?[0].icon}';
    final String setIcon = '$_iconUrlPath$getIcon.png';
    return setIcon;
  }

  double dayTemp = 0;
  double setDayTemp(int index) {
    dayTemp = ((weatherData?.daily?[0].temp?.day ?? -kelvin) + kelvin)
        .roundToDouble();
    return dayTemp;
  }

  double nightTemp = 0;
  double setNightTemp(int index) {
    nightTemp = ((weatherData?.daily?[0].temp?.night ?? -kelvin) + kelvin)
        .roundToDouble();
    return nightTemp;
  }

  //weather data
  final List<dynamic> weatherValue = [];
  dynamic setValues(int index) {
    weatherValue.add((current?.windSpeed ?? 0));
    weatherValue
        .add(((current?.feelsLike ?? -kelvin) + kelvin).roundToDouble());
    weatherValue.add((current?.humidity ?? 0) / 1);
    weatherValue.add((current?.visibility ?? 0) / 1000);
    return weatherValue[index];
  }

  String sunRise = '';
  String setCurrentSunRise() {
    final getSunTime =
        (current?.sunrise ?? 0) + (weatherData?.timezoneOffset ?? 0);
    final setSunRise = DateTime.fromMillisecondsSinceEpoch(getSunTime * 1000);
    sunRise = DateFormat('HH:mm a').format(setSunRise);
    return sunRise;
  }

  String sunSet = '';
  String setCurrentSunSet() {
    final getSunTime =
        (current?.sunset ?? 0) + (weatherData?.timezoneOffset ?? 0);
    final setSunSet = DateTime.fromMillisecondsSinceEpoch(getSunTime * 1000);
    sunSet = DateFormat('HH:mm a').format(setSunSet);
    return sunSet;
  }

  var box = Hive.box<FavoriteHistory>(HiveBoxs.favoriteBox);

  Future<void> setFavorite(BuildContext context, {String? cityName}) async {
    box
        .add(FavoriteHistory(
          currentCity: cityName ?? 'Error',
          currentZone: weatherData?.timezone ?? 'Error',
          bg: currentBg ?? AppBg.shinyDay,
          icon: iconData(),
          currentTemp: currentTemp.toDouble(),
        ))
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColor.sevenDaysColor,
            content: Text('City $cityName'))));
  }

  Future<void> deleteFavorite(int index) async {
    box.deleteAt(index);
  }

  Future<void> setCurrentCity(BuildContext context, {String? cityName}) async {
    if (searchController.text != '') {
      cityName = searchController.text;

      (await pref)
          .setString('city', cityName);
          await setUp(cityName: (await pref).getString('city'))
          .then((value) => Navigator.pop(context)).then((value) => searchController.clear());
         
      notifyListeners();
    }
  }
}
