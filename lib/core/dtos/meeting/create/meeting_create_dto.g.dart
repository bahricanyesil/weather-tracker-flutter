// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingCreate _$MeetingCreateFromJson(Map<String, dynamic> json) {
  return MeetingCreate(
    json['country'] as String,
    json['city'] as String,
    (json['participantIds'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$MeetingCreateToJson(MeetingCreate instance) =>
    <String, dynamic>{
      'country': instance.country,
      'city': instance.city,
      'participantIds': instance.participantIds,
    };
