import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../core_shelf.dart';

class FriendProvider extends ChangeNotifier {
  UserModel user = UserModel("fake", "fake", "fake", "fake", "fake", "fake");
  String errorMessage = '';
  List<UserModel> friendsOfUser = [
    UserModel("fake", "fake", "fake", "fake", "fake", "fake",
        imageUrl: "https://randomuser.me/api/portraits/med/women/31.jpg"),
    UserModel("fake", "fake", "fake", "fake", "fake", "fake",
        imageUrl: "https://randomuser.me/api/portraits/med/women/31.jpg"),
    UserModel("fake", "fake", "fake", "fake", "fake", "fake",
        imageUrl: "https://randomuser.me/api/portraits/med/women/31.jpg"),
    UserModel("fake", "fake", "fake", "fake", "fake", "fake",
        imageUrl: "https://randomuser.me/api/portraits/med/women/31.jpg"),
    UserModel("fake", "fake", "fake", "fake", "fake", "fake",
        imageUrl: "https://randomuser.me/api/portraits/med/women/31.jpg"),
    UserModel("fake", "fake", "fake", "fake", "fake", "fake",
        imageUrl: "https://randomuser.me/api/portraits/med/women/31.jpg"),
    UserModel("fake", "fake", "fake", "fake", "1", "1",
        imageUrl: "https://randomuser.me/api/portraits/med/women/31.jpg"),
  ];
  List<UserModel> receivedRequests = [
    UserModel("fake", "fake", "fake", "fake", "2", "2",
        imageUrl: "https://randomuser.me/api/portraits/med/women/31.jpg"),
  ];
  List<UserModel> sentRequests = [
    UserModel("fake", "fake", "fake", "fake", "3", "3",
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
