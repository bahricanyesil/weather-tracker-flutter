// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePassword _$ChangePasswordFromJson(Map<String, dynamic> json) {
  return ChangePassword(
    json['email'] as String,
    json['oldPassword'] as String,
    json['newPassword'] as String,
  );
}

Map<String, dynamic> _$ChangePasswordToJson(ChangePassword instance) =>
    <String, dynamic>{
      'email': instance.email,
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
    };
