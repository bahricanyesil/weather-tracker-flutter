import 'package:json_annotation/json_annotation.dart';

part 'user_create_dto.g.dart';

@JsonSerializable()
class UserCreate {
  String userName;
  String email;
  String password;

  UserCreate(this.userName, this.email, this.password);
  factory UserCreate.fromJson(Map<String, dynamic> json) =>
      _$UserCreateFromJson(json);
  Map<String, dynamic> toJson() => _$UserCreateToJson(this);
}
