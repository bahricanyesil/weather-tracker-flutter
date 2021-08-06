import 'package:json_annotation/json_annotation.dart';

part 'user_update_dto.g.dart';

@JsonSerializable()
class UserUpdate {
  String userName;
  String country;
  String city;
  String notificationToken;

  UserUpdate(this.userName, this.country, this.city, this.notificationToken);
  factory UserUpdate.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$UserUpdateToJson(this);
}
