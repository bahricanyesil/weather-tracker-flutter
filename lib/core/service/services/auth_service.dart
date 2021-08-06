import 'package:dio/dio.dart';

import '../../core_shelf.dart';

class AuthService {
  static final AuthService _instance = AuthService._init();
  static AuthService get instance => _instance;
  AuthService._init();

  static final String _baseUrl = '${ServiceUtils.baseText}/users';

  static final String _login = '$_baseUrl/login';
  static final String _usersByName = '$_baseUrl/name/';
  static final String _forgotPass = '$_baseUrl/forgotPass/';
  static final String _changePass = '$_baseUrl/changePass';
  static final String _verify = '$_baseUrl/verify';

  Future<UserModel> login(Login login) async {
    try {
      final userLoginJson = login.toJson();
      final res =
          await NetworkManager.instance.postRequest(_login, userLoginJson, '');
      await ServiceUtils.instance.setToken(res['token']);
      return UserModel.fromJson(res['user']);
    } on DioError {
      rethrow;
    }
  }

  Future<UserModel> register(UserCreate userCreate) async {
    try {
      final userCreateJson = userCreate.toJson();
      final res = await NetworkManager.instance
          .postRequest(_baseUrl, userCreateJson, '');
      await ServiceUtils.instance.setToken(res['token']);
      return UserModel.fromJson(res['user']);
    } on DioError {
      rethrow;
    }
  }

  Future<List<UserModel>> getUsersByName(String username) async {
    try {
      final token = await ServiceUtils.instance.getToken();
      final res = await NetworkManager.instance
          .getRequest(_usersByName + username, token);
      return (res['users'] as List)
          .map((user) => UserModel.fromJson(user))
          .toList();
    } on DioError {
      rethrow;
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      final token = await ServiceUtils.instance.getToken();
      final res =
          await NetworkManager.instance.getRequest('$_baseUrl/$id', token);
      return UserModel.fromJson(res['user']);
    } on DioError {
      rethrow;
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      final res =
          await NetworkManager.instance.getRequest(_forgotPass + email, '');
      await ServiceUtils.instance.setToken(res['token']);
    } on DioError {
      rethrow;
    }
  }

  Future<void> updateUser(String id, UserUpdate userUpdate) async {
    try {
      final userUpdateJson = userUpdate.toJson();
      final token = await ServiceUtils.instance.getToken();
      await NetworkManager.instance
          .putRequest('$_baseUrl/$id', userUpdateJson, token);
    } on DioError {
      rethrow;
    }
  }

  Future<void> changePassword(ChangePassword changePassDto) async {
    try {
      final changePassDtoJson = changePassDto.toJson();
      final token = await ServiceUtils.instance.getToken();
      await NetworkManager.instance
          .postRequest(_changePass, changePassDtoJson, token);
    } on DioError {
      rethrow;
    }
  }

  Future<String> verifyEmail(VerifyEmail verifyEmailDto) async {
    try {
      final verifyEmailDtoJson = verifyEmailDto.toJson();
      final res = await NetworkManager.instance
          .postRequest(_verify, verifyEmailDtoJson, '');
      await ServiceUtils.instance.setToken(res['token']);
      return res['userId'];
    } on DioError {
      rethrow;
    }
  }
}
