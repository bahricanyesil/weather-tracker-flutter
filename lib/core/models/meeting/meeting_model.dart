import 'package:json_annotation/json_annotation.dart';
import '../user/user_model.dart';

part 'meeting_model.g.dart';

@JsonSerializable()
class MeetingModel {
  String country;
  String city;
  String uniqueId;
  List<UserModel> participances = [];

  MeetingModel(this.country, this.city, this.uniqueId);
  factory MeetingModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingModelFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingModelToJson(this);
}
