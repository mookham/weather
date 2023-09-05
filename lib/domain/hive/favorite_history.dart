import 'package:hive/hive.dart';
part 'favorite_history.g.dart';

@HiveType(typeId: 0)
class FavoriteHistory {
  @HiveField(0)
  String currentCity;

  @HiveField(1)
  String currentZone;

  @HiveField(2)
  String icon;

  @HiveField(3)
  double currentTemp;

  @HiveField(4)
  String bg;
  FavoriteHistory(
      {this.currentCity = '',
      this.currentZone = '',
      this.icon = '',
      this.currentTemp = 0,
      this.bg = ''});
}
