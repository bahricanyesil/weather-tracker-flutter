// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingModel _$MeetingModelFromJson(Map<String, dynamic> json) {
  return MeetingModel(
    json['country'] as String,
    json['city'] as String,
    json['uniqueId'] as String,
  );
}

Map<String, dynamic> _$MeetingModelToJson(MeetingModel instance) =>
    <String, dynamic>{
      'country': instance.country,
      'city': instance.city,
      'uniqueId': instance.uniqueId,
    };
