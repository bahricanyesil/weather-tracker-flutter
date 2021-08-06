// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_email_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyEmail _$VerifyEmailFromJson(Map<String, dynamic> json) {
  return VerifyEmail(
    json['email'] as String,
    json['code'] as String,
    json['token'] as String,
  );
}

Map<String, dynamic> _$VerifyEmailToJson(VerifyEmail instance) =>
    <String, dynamic>{
      'email': instance.email,
      'code': instance.code,
      'token': instance.token,
    };
