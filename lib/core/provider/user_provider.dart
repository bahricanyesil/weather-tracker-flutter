import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../core_shelf.dart';

class UserProvider extends ChangeNotifier {
  UserModel user = UserModel("Bahrican Yeşil", "bahricanyesil@gmail.com",
      "Turkey", "Istanbul", "fake", "fake");
  String errorMessage = '';
  List<UserModel> searchedUsers = [];

  Future<void> login(String email, String password) async {
    var loginModel = Login(email, password);
    try {
      user = await AuthService.instance.login(loginModel);
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }

  Future<void> register(String email, String password, String username) async {
    var registerModel = UserCreate(username, email, password);
    try {
      user = await AuthService.instance.register(registerModel);
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }

  Future<void> getUsersByName(String username) async {
    try {
      searchedUsers = await AuthService.instance.getUsersByName(username);
      notifyListeners();
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }

  Future<void> getUserById(String id) async {
    try {
      user = await AuthService.instance.getUserById(id);
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await AuthService.instance.forgotPassword(email);
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }

  Future<void> updateUser(String id, String username, String country,
      String city, String notificationToken) async {
    final userUpdateModel =
        UserUpdate(username, country, city, notificationToken);
    try {
      await AuthService.instance.updateUser(id, userUpdateModel);
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    final changePasswordModel =
        ChangePassword(user.email, oldPassword, newPassword);
    try {
      await AuthService.instance.changePassword(changePasswordModel);
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }

  Future<void> verifyEmail(String email, String code) async {
    final token = await ServiceUtils.instance.getToken();
    final verifyEmailModel = VerifyEmail(user.email, code, token);
    try {
      user.uniqueId = await AuthService.instance.verifyEmail(verifyEmailModel);
    } on DioError catch (error) {
      errorMessage = ServiceUtils.instance.checkError(error);
    }
  }
}
