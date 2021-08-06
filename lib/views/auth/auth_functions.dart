import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/core_shelf.dart';

class AuthFunctions {
  static final AuthFunctions _instance = AuthFunctions();
  static AuthFunctions get instance => _instance;

  Future<void> login(
      String email, String password, BuildContext context) async {
    if (isValidError(email, 'email', context) &&
        isValidError(password, 'password', context)) {
      email = email.trim();
      password = password.trim();
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      // await ServiceUtils.instance.requestHelper(
      //   () => userProvider.login(email, password),
      //   context,
      // );
      if (Utils.instance.errorDialogHelper(userProvider, context)) {
        NavigationService.instance
            .navigateToPage(path: NavigationConstants.home);
      }
    }
  }

  Future<void> register(String email, String password, String confirmPass,
      String username, BuildContext context) async {
    if (checkAll(username, email, password, confirmPass, context)) {
      username = username.turkishCharToEnglish.trim();
      email = email.trim();
      password = password.trim();
      confirmPass = confirmPass.trim();
      if (passwordsMatch(password, confirmPass, context)) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        // await ServiceUtils.instance.requestHelper(
        //   () => userProvider.register(email, password, username),
        //   context,
        // );
        if (Utils.instance.errorDialogHelper(userProvider, context)) {
          NavigationService.instance.navigateToPage(
              path: NavigationConstants.verifyEmail, data: {'email': email});
        }
      }
    }
  }

  Future<void> forgotPassword(String email, BuildContext context) async {
    if (isValidError(email, 'email', context)) {
      email = email.trim();
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      // await ServiceUtils.instance.requestHelper(
      //   () => userProvider.forgotPassword(email),
      //   context,
      // );
      if (Utils.instance.errorDialogHelper(userProvider, context)) {
        NavigationService.instance.navigateToPage(
            path: NavigationConstants.verifyEmail, data: {'email': email});
      }
    }
  }

  Future<void> changePassword(
      String oldPassword, String newPassword, BuildContext context) async {
    if (isValidError(oldPassword, 'password', context) &&
        isValidError(newPassword, 'password', context)) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await ServiceUtils.instance.requestHelper(
        () => userProvider.changePassword(oldPassword, newPassword),
        context,
      );
      if (Utils.instance.errorDialogHelper(userProvider, context)) {
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> verifyEmail(
      String email, String code, BuildContext context) async {
    if (code.length < 4 || !code.isNumeric) {
      Utils.instance.textDialog(context, 'not_numeric_code');
    } else {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      // await ServiceUtils.instance.requestHelper(
      //   () => userProvider.verifyEmail(email, code),
      //   context,
      // );
      if (Utils.instance.errorDialogHelper(userProvider, context)) {
        NavigationService.instance
            .navigateToPage(path: NavigationConstants.home);
      }
    }
  }

  static bool isValidError(String text, String type, BuildContext context) {
    var isValid = false;
    var errorMessage = '';
    if (type == 'email' && !text.isValidEmail) {
      errorMessage = 'invalid_email';
    } else if (type == 'password' && !text.isValidPassword) {
      if (text.length < 8) {
        errorMessage = 'password_length';
      } else {
        errorMessage = 'invalid_password';
      }
    } else if (type == 'username' && !text.isValidName) {
      errorMessage = 'invalid_name';
    } else {
      isValid = true;
    }
    if (!isValid) Utils.instance.textDialog(context, errorMessage);
    return isValid;
  }

  static bool checkAll(String name, String email, String firstPass,
      String secondPass, BuildContext context) {
    return isValidError(email, 'email', context) &&
        isValidError(firstPass, 'password', context) &&
        isValidError(secondPass, 'password', context) &&
        isValidError(name, 'username', context);
  }

  static bool passwordsMatch(
      String firstPass, String secondPass, BuildContext context) {
    if (firstPass == secondPass) return true;
    Utils.instance.textDialog(context, 'password_match_error');
    return false;
  }
}
