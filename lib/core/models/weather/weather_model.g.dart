// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) {
  return WeatherModel(
    (json['temperature'] as num).toDouble(),
    DateTime.parse(json['lastUpdated'] as String),
    json['condition'] as String,
    json['conditionIconUrl'] as String,
    (json['windSpeed'] as num).toDouble(),
    (json['cloud'] as num).toInt(),
  );
}

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'condition': instance.condition,
      'conditionIconUrl': instance.conditionIconUrl,
      'windSpeed': instance.windSpeed,
      'cloud': instance.cloud,
    };
