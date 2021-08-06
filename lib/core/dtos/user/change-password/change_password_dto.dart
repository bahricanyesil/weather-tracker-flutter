import 'package:json_annotation/json_annotation.dart';

part 'change_password_dto.g.dart';

@JsonSerializable()
class ChangePassword {
  String email;
  String oldPassword;
  String newPassword;

  ChangePassword(this.email, this.oldPassword, this.newPassword);
  factory ChangePassword.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePasswordToJson(this);
}
