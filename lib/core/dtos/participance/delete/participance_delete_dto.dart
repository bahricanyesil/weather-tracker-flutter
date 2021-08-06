import 'package:json_annotation/json_annotation.dart';

part 'participance_delete_dto.g.dart';

@JsonSerializable()
class ParticipanceDelete {
  String userId;
  String meetingId;

  ParticipanceDelete(this.userId, this.meetingId);
  factory ParticipanceDelete.fromJson(Map<String, dynamic> json) =>
      _$ParticipanceDeleteFromJson(json);
  Map<String, dynamic> toJson() => _$ParticipanceDeleteToJson(this);
}
