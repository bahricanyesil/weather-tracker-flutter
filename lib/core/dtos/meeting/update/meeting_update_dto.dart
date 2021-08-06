import 'package:json_annotation/json_annotation.dart';

part 'meeting_update_dto.g.dart';

@JsonSerializable()
class MeetingUpdate {
  String country;
  String city;

  MeetingUpdate(this.country, this.city);
  factory MeetingUpdate.fromJson(Map<String, dynamic> json) =>
      _$MeetingUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingUpdateToJson(this);
}
