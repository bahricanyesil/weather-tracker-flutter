import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String userName;
  String email;
  String country;
  String city;
  String uniqueId;
  String notificationToken;
  String imageUrl;

  UserModel(this.userName, this.email, this.country, this.city, this.uniqueId,
      this.notificationToken,
      {this.imageUrl = ''});
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
