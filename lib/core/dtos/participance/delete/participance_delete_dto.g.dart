// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participance_delete_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipanceDelete _$ParticipanceDeleteFromJson(Map<String, dynamic> json) {
  return ParticipanceDelete(
    json['userId'] as String,
    json['meetingId'] as String,
  );
}

Map<String, dynamic> _$ParticipanceDeleteToJson(ParticipanceDelete instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'meetingId': instance.meetingId,
    };
