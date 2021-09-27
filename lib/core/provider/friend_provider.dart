import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../core_shelf.dart';

class FriendProvider extends ChangeNotifier {
  UserModel user = UserModel("fake", "fake", "fake", "fake", "fake", "fake");
  String errorMessage = '';
  List<UserModel> friendsOfUser = List.generate(
      15,
      (int index) => UserModel(
          "fakename$index",
          "fakeemail$index",
          "fakecountry$index",
          "fakecity$index",
          "fakeid$index",
          "faketoken$index",
          imageUrl: "https://randomuser.me/api/portraits/med/women/31.jpg"));

  List<UserModel> receivedRequests = [
    UserModel("fakename10", "fakeemail10", "fakecountry10", "fakecity10",
        "fakeid10", "faketoken10",
        imageUrl: "https://randomuser.me/api/portraits/med/women/31.jpg"),
  ];
  List<UserModel> sentRequests = [
    UserModel("fakename8", "fakeemail8", "fakecountry8", "fakecity8", "fakeid8",
        "faketoken8",
        imageUrl: "https://randomuser.me/api/portraits/med/women/31.jpg"),
  ];

  Future<void> getFriendsOfUser(String userId) async {
    try {
      friendsOfUser = await FriendService.instance.getFriendsOfUser(userId);
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }

  Future<void> getReceivedRequests(String userId) async {
    try {
      receivedRequests =
          await FriendService.instance.getReceivedRequests(userId);
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }

  Future<void> getRequestAndFriends(String userId) async {
    try {
      final response =
          await FriendService.instance.getRequestAndFriends(userId);
      receivedRequests = response['requests']!;
      friendsOfUser = response['friends']!;
      sentRequests = response['sends']!;
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }

  Future<void> rejectRequest(String senderId, String receiverId) async {
    try {
      final friendUpdateDto = FriendCreate(senderId, receiverId);
      await FriendService.instance.rejectRequest(friendUpdateDto);
      receivedRequests.removeWhere((element) => element.uniqueId == senderId);
      notifyListeners();
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }

  Future<void> acceptRequest(String senderId, String receiverId) async {
    try {
      final friendUpdateDto = FriendCreate(senderId, receiverId);
      await FriendService.instance.acceptRequest(friendUpdateDto);
      final userIndex = receivedRequests
          .indexWhere((element) => element.uniqueId == senderId);
      if (userIndex != -1) {
        friendsOfUser.add(receivedRequests[userIndex]);
        receivedRequests.removeAt(userIndex);
      }
      notifyListeners();
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }

  Future<void> createFriend(String senderId, UserModel user) async {
    try {
      final friendUpdateDto = FriendCreate(senderId, user.uniqueId);
      await FriendService.instance.createFriend(friendUpdateDto);
      sentRequests.add(user);
      notifyListeners();
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }
}
