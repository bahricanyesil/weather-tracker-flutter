// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    json['userName'] as String,
    json['email'] as String,
    json['country'] as String,
    json['city'] as String,
    json['uniqueId'] as String,
    json['notificationToken'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userName': instance.userName,
      'email': instance.email,
      'country': instance.country,
      'city': instance.city,
      'uniqueId': instance.uniqueId,
      'notificationToken': instance.notificationToken,
    };
