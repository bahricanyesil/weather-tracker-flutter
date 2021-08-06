import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../core_shelf.dart';

class ParticipanceProvider extends ChangeNotifier {
  String errorMessage = '';
  List<MeetingModel> meetings = [
    MeetingModel("Turkey", "Istanbul", "uniqueId"),
    MeetingModel("Turkey", "Ankara", "uniqueId"),
    MeetingModel("Turkey", "Ankara", "uniqueId"),
    MeetingModel("Turkey", "Ankara", "uniqueId"),
  ];
  List<UserModel> users = [];
  ParticipanceModel participance = ParticipanceModel(0, "fake", "fake", "fake");

  Future<void> getMeetingsByUserId(String userId) async {
    try {
      meetings = await ParticipanceService.instance.getMeetingsByUserId(userId);
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }

  Future<void> getUsersByMeetingId(String meetingId) async {
    try {
      users = await ParticipanceService.instance.getUsersByMeetingId(meetingId);
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }

  Future<void> getParticipanceById(String participanceId) async {
    try {
      participance = await ParticipanceService.instance
          .getParticipanceById(participanceId);
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }

  Future<void> deleteParticipance(String userId, String meetingId) async {
    try {
      final deleteParticipanceModel = ParticipanceDelete(userId, meetingId);
      await ParticipanceService.instance
          .deleteParticipance(deleteParticipanceModel);
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }
}
