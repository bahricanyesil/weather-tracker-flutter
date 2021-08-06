// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_update_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserUpdate _$UserUpdateFromJson(Map<String, dynamic> json) {
  return UserUpdate(
    json['userName'] as String,
    json['country'] as String,
    json['city'] as String,
    json['notificationToken'] as String,
  );
}

Map<String, dynamic> _$UserUpdateToJson(UserUpdate instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'country': instance.country,
      'city': instance.city,
      'notificationToken': instance.notificationToken,
    };
