import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../core_shelf.dart';

class MeetingProvider extends ChangeNotifier {
  String errorMessage = '';
  MeetingModel meeting = MeetingModel("fake", "fake", "fake");
  WeatherModel weather =
      WeatherModel(0, DateTime.now(), "condition", "conditionIconUrl", 0, 0);

  Future<void> getMeetingById(String meetingId) async {
    try {
      meeting = await MeetingService.instance.getMeetingById(meetingId);
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }

  Future<void> createMeeting(
      String country, String city, List<String> participantIds) async {
    final meetingCreateDto = MeetingCreate(country, city, participantIds);
    try {
      meeting = await MeetingService.instance.createMeeting(meetingCreateDto);
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }

  Future<void> updateMeeting(
      String meetingId, String country, String city) async {
    final meetingUpdateDto = MeetingUpdate(country, city);
    try {
      await MeetingService.instance.updateMeeting(meetingId, meetingUpdateDto);
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }

  Future<void> getWeather(String meetingId) async {
    try {
      weather = await MeetingService.instance.getWeather(meetingId);
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }
}
