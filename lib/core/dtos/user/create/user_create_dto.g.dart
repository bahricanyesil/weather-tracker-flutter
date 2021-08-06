// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCreate _$UserCreateFromJson(Map<String, dynamic> json) {
  return UserCreate(
    json['userName'] as String,
    json['email'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$UserCreateToJson(UserCreate instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'email': instance.email,
      'password': instance.password,
    };
