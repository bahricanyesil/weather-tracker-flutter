// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendModel _$FriendModelFromJson(Map<String, dynamic> json) {
  return FriendModel(
    json['id'] as int,
    json['senderId'] as String,
    json['receiverId'] as String,
    json['isWaiting'] as String,
    json['uniqueId'] as String,
  );
}

Map<String, dynamic> _$FriendModelToJson(FriendModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'isWaiting': instance.isWaiting,
      'uniqueId': instance.uniqueId,
    };
