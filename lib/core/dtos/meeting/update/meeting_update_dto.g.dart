// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_update_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingUpdate _$MeetingUpdateFromJson(Map<String, dynamic> json) {
  return MeetingUpdate(
    json['country'] as String,
    json['city'] as String,
  );
}

Map<String, dynamic> _$MeetingUpdateToJson(MeetingUpdate instance) =>
    <String, dynamic>{
      'country': instance.country,
      'city': instance.city,
    };
