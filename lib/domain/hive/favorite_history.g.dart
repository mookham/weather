// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteHistoryAdapter extends TypeAdapter<FavoriteHistory> {
  @override
  final int typeId = 0;

  @override
  FavoriteHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteHistory(
      currentCity: fields[0] as String,
      currentZone: fields[1] as String,
      icon: fields[2] as String,
      currentTemp: fields[3] as double,
      bg: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteHistory obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.currentCity)
      ..writeByte(1)
      ..write(obj.currentZone)
      ..writeByte(2)
      ..write(obj.icon)
      ..writeByte(3)
      ..write(obj.currentTemp)
      ..writeByte(4)
      ..write(obj.bg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
