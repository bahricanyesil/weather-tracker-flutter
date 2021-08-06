import 'package:json_annotation/json_annotation.dart';

part 'verify_email_dto.g.dart';

@JsonSerializable()
class VerifyEmail {
  String email;
  String code;
  String token;

  VerifyEmail(this.email, this.code, this.token);
  factory VerifyEmail.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyEmailToJson(this);
}
