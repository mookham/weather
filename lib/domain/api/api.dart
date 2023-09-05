import 'package:dio/dio.dart';
import 'package:flutter_application_1/domain/models/coord.dart';
import 'package:flutter_application_1/domain/models/weather_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class  Api {
  static final apiKey = dotenv.get('API_KEY');
  
  static Future<Coord> getCoords({String cityName = 'Tashkent'})async{
    final dio = Dio();
    final response = await dio.get('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&lang=ru');
    try {
     final coords = Coord.fromJson(response.data);
     return coords;
    } catch (e) {
      final coords = Coord.fromJson(response.data);
     return coords;
      
    }
  }
  static Future<WeatherData?> getWeather(Coord? coord)async{
    if (coord != null) {
      final dio = Dio();
      final lat = coord.lat.toString();
      
      final lon = coord.lon.toString();
      
      final response = await dio.get('https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=hourly,minutely&appid=$apiKey&lang=ru');
  
      final weatherData = WeatherData.fromJson(response.data);
      
      return weatherData;
    }
    return null;
  }
}