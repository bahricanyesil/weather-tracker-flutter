import 'package:json_annotation/json_annotation.dart';

part 'meeting_create_dto.g.dart';

@JsonSerializable()
class MeetingCreate {
  String country;
  String city;
  List<String> participantIds;

  MeetingCreate(this.country, this.city, this.participantIds);
  factory MeetingCreate.fromJson(Map<String, dynamic> json) =>
      _$MeetingCreateFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingCreateToJson(this);
}
