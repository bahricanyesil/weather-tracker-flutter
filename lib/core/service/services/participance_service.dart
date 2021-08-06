import 'package:dio/dio.dart';

import '../../core_shelf.dart';

class ParticipanceService {
  static final ParticipanceService _instance = ParticipanceService._init();
  static ParticipanceService get instance => _instance;
  ParticipanceService._init();

  static final String _baseUrl = '${ServiceUtils.baseText}/participances';

  static final String _user = '$_baseUrl/user/';
  static final String _meeting = '$_baseUrl/meeting/';

  Future<List<MeetingModel>> getMeetingsByUserId(String userId) async {
    try {
      final token = await ServiceUtils.instance.getToken();
      final res =
          await NetworkManager.instance.getRequest(_user + userId, token);
      return (res['meetings'] as List)
          .map((meeting) => MeetingModel.fromJson(meeting))
          .toList();
    } on DioError {
      rethrow;
    }
  }

  Future<List<UserModel>> getUsersByMeetingId(String meetingId) async {
    try {
      final token = await ServiceUtils.instance.getToken();
      final res =
          await NetworkManager.instance.getRequest(_meeting + meetingId, token);
      return (res['users'] as List)
          .map((user) => UserModel.fromJson(user))
          .toList();
    } on DioError {
      rethrow;
    }
  }

  Future<ParticipanceModel> getParticipanceById(String participanceId) async {
    try {
      final token = await ServiceUtils.instance.getToken();
      final res = await NetworkManager.instance
          .getRequest('$_baseUrl/$participanceId', token);
      return ParticipanceModel.fromJson(res['participance']);
    } on DioError {
      rethrow;
    }
  }

  Future<void> deleteParticipance(
      ParticipanceDelete participanceDeleteDto) async {
    try {
      final participanceDeleteDtoJson = participanceDeleteDto.toJson();
      final token = await ServiceUtils.instance.getToken();
      await NetworkManager.instance
          .deleteRequest(_baseUrl, participanceDeleteDtoJson, token);
    } on DioError {
      rethrow;
    }
  }
}
