import 'package:json_annotation/json_annotation.dart';

part 'participance_model.g.dart';

@JsonSerializable()
class ParticipanceModel {
  int id;
  String country;
  String city;
  String uniqueId;

  ParticipanceModel(this.id, this.country, this.city, this.uniqueId);
  factory ParticipanceModel.fromJson(Map<String, dynamic> json) =>
      _$ParticipanceModelFromJson(json);
  Map<String, dynamic> toJson() => _$ParticipanceModelToJson(this);
}
