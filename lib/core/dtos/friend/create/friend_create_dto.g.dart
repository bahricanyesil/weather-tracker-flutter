// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendCreate _$FriendCreateFromJson(Map<String, dynamic> json) {
  return FriendCreate(
    json['senderId'] as String,
    json['receiverId'] as String,
  );
}

Map<String, dynamic> _$FriendCreateToJson(FriendCreate instance) =>
    <String, dynamic>{
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
    };
