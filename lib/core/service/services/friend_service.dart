import 'package:dio/dio.dart';

import '../../core_shelf.dart';

class FriendService {
  static final FriendService _instance = FriendService._init();
  static FriendService get instance => _instance;
  FriendService._init();

  static final String _baseUrl = '${ServiceUtils.baseText}/friends';

  static final String _receivedRequests = '$_baseUrl/receivedRequests/';
  static final String _requestsAndFriends = '$_baseUrl/requestAndFriends/';
  static final String _accept = '$_baseUrl/accept';
  static final String _reject = '$_baseUrl/reject';

  Future<List<UserModel>> getFriendsOfUser(String userId) async {
    try {
      final token = await ServiceUtils.instance.getToken();
      final res =
          await NetworkManager.instance.getRequest('$_baseUrl/$userId', token);
      return (res['friends'] as List)
          .map((friend) => UserModel.fromJson(friend))
          .toList();
    } on DioError {
      rethrow;
    }
  }

  Future<List<UserModel>> getReceivedRequests(String userId) async {
    try {
      final token = await ServiceUtils.instance.getToken();
      final res = await NetworkManager.instance
          .getRequest(_receivedRequests + userId, token);
      return (res['users'] as List)
          .map((user) => UserModel.fromJson(user))
          .toList();
    } on DioError {
      rethrow;
    }
  }

  Future<Map<String, List<UserModel>>> getRequestAndFriends(
      String userId) async {
    try {
      final token = await ServiceUtils.instance.getToken();
      final res = await NetworkManager.instance
          .getRequest(_requestsAndFriends + userId, token);
      final requests = (res['requests'] as List)
          .map((user) => UserModel.fromJson(user))
          .toList();
      final friends = (res['friends'] as List)
          .map((user) => UserModel.fromJson(user))
          .toList();
      final sends = (res['sends'] as List)
          .map((user) => UserModel.fromJson(user))
          .toList();
      final response = {
        "requests": requests,
        "friends": friends,
        "sends": sends,
      };
      return response;
    } on DioError {
      rethrow;
    }
  }

  Future<void> rejectRequest(FriendCreate friendUpdateDto) async {
    try {
      final friendUpdateDtoJson = friendUpdateDto.toJson();
      final token = await ServiceUtils.instance.getToken();
      await NetworkManager.instance
          .putRequest(_reject, friendUpdateDtoJson, token);
    } on DioError {
      rethrow;
    }
  }

  Future<void> acceptRequest(FriendCreate friendUpdateDto) async {
    try {
      final friendUpdateDtoJson = friendUpdateDto.toJson();
      final token = await ServiceUtils.instance.getToken();
      await NetworkManager.instance
          .putRequest(_accept, friendUpdateDtoJson, token);
    } on DioError {
      rethrow;
    }
  }

  Future<void> createFriend(FriendCreate friendCreateDto) async {
    try {
      final friendCreateDtoJson = friendCreateDto.toJson();
      final token = await ServiceUtils.instance.getToken();
      await NetworkManager.instance
          .postRequest(_baseUrl, friendCreateDtoJson, token);
    } on DioError {
      rethrow;
    }
  }
}
