import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../views/views_shelf.dart';
import '../../core_shelf.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.login:
        return normalNavigate(const LoginScreen());
      case NavigationConstants.register:
        return normalNavigate(const RegisterScreen());
      case NavigationConstants.home:
        return normalNavigate(const MainScreen());
      case NavigationConstants.forgotPassword:
        return normalNavigate(const ForgotPasswordScreen());
      case NavigationConstants.changePassword:
        return normalNavigate(const ChangePasswordScreen());
      case NavigationConstants.verifyEmail:
        final email = (args.arguments as Map)['email'];
        return normalNavigate(VerifyEmailScreen(email: email));
      default:
        return normalNavigate(const LoginScreen());
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }
}
