// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipanceModel _$ParticipanceModelFromJson(Map<String, dynamic> json) {
  return ParticipanceModel(
    json['id'] as int,
    json['country'] as String,
    json['city'] as String,
    json['uniqueId'] as String,
  );
}

Map<String, dynamic> _$ParticipanceModelToJson(ParticipanceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'country': instance.country,
      'city': instance.city,
      'uniqueId': instance.uniqueId,
    };
