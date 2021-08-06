import 'package:dio/dio.dart';

import '../../core_shelf.dart';

class MeetingService {
  static final MeetingService _instance = MeetingService._init();
  static MeetingService get instance => _instance;
  MeetingService._init();

  static final String _baseUrl = '${ServiceUtils.baseText}/meetings';

  static final String _weather = '$_baseUrl/weather/';

  Future<MeetingModel> getMeetingById(String meetingId) async {
    try {
      final token = await ServiceUtils.instance.getToken();
      final res = await NetworkManager.instance
          .getRequest('$_baseUrl/$meetingId', token);
      return MeetingModel.fromJson(res['meeting']);
    } on DioError {
      rethrow;
    }
  }

  Future<MeetingModel> createMeeting(MeetingCreate meetingCreateDto) async {
    try {
      final meetingCreateDtoJson = meetingCreateDto.toJson();
      final token = await ServiceUtils.instance.getToken();
      final res = await NetworkManager.instance
          .postRequest(_baseUrl, meetingCreateDtoJson, token);
      return MeetingModel.fromJson(res['meeting']);
    } on DioError {
      rethrow;
    }
  }

  Future<void> updateMeeting(
      String meetingId, MeetingUpdate meetingUpdateDto) async {
    try {
      final meetingUpdateDtoJson = meetingUpdateDto.toJson();
      final token = await ServiceUtils.instance.getToken();
      await NetworkManager.instance
          .putRequest('$_baseUrl/$meetingId', meetingUpdateDtoJson, token);
    } on DioError {
      rethrow;
    }
  }

  Future<WeatherModel> getWeather(String meetingId) async {
    try {
      final token = await ServiceUtils.instance.getToken();
      final res = await NetworkManager.instance.getRequest(
          "https://api.weatherapi.com/v1/current.json?key=cd543e4c763f4b40a3a92040211307&q=Istanbul&aqi=no",
          token);
      final date = DateTime.fromMillisecondsSinceEpoch(
          res['current']['last_updated_epoch']);
      return WeatherModel(
          res['current']['temp_c'],
          date,
          res['current']['condition']['text'],
          res['current']['condition']['icon'],
          res['current']['wind_kph'],
          res['current']['cloud']);
      // final res =
      //     await NetworkManager.instance.getRequest(_weather + meetingId, token);
      // return WeatherModel.fromJson(res['weather']);
    } on DioError {
      rethrow;
    }
  }
}
