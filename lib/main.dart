import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/domain/hive/favorite_history.dart';
import 'package:flutter_application_1/domain/hive/hive_boxs.dart';

import 'package:flutter_application_1/weather_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:hive_flutter/adapters.dart';

Future<void> main(List<String> args) async{
  
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteHistoryAdapter());
  await Hive.openBox<FavoriteHistory>(HiveBoxs.favoriteBox);
  await dotenv.load(fileName: '.env');

  
  runApp(const WeatherApp());
}

