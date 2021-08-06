import 'package:json_annotation/json_annotation.dart';

part 'friend_model.g.dart';

@JsonSerializable()
class FriendModel {
  int id;
  String senderId;
  String receiverId;
  String isWaiting;
  String uniqueId;

  FriendModel(
      this.id, this.senderId, this.receiverId, this.isWaiting, this.uniqueId);
  factory FriendModel.fromJson(Map<String, dynamic> json) =>
      _$FriendModelFromJson(json);
  Map<String, dynamic> toJson() => _$FriendModelToJson(this);
}
