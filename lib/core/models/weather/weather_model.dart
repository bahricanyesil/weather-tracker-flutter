import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  double temperature;
  DateTime lastUpdated;
  String condition;
  String conditionIconUrl;
  double windSpeed;
  int cloud;

  WeatherModel(this.temperature, this.lastUpdated, this.condition,
      this.conditionIconUrl, this.windSpeed, this.cloud);
  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}
