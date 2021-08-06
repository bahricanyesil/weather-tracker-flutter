import 'package:json_annotation/json_annotation.dart';

part 'friend_create_dto.g.dart';

@JsonSerializable()
class FriendCreate {
  String senderId;
  String receiverId;

  FriendCreate(this.senderId, this.receiverId);
  factory FriendCreate.fromJson(Map<String, dynamic> json) =>
      _$FriendCreateFromJson(json);
  Map<String, dynamic> toJson() => _$FriendCreateToJson(this);
}
