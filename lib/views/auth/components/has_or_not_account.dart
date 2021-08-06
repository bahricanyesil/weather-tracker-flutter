import 'package:flutter/material.dart';

import '../../../core/core_shelf.dart';
import '../auth_functions.dart';

class HasOrNotAccount extends StatelessWidget {
  final String type;
  final String? email;
  final Function()? func;
  final MainAxisAlignment mainAxisAlignment;
  const HasOrNotAccount(
    this.type, {
    Key? key,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.email,
    this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        AutoSizeText(type.translate),
        SizedBox(width: context.width),
        textButton(context),
        SizedBox(width: context.width * (type == 'forgotPass' ? 12 : 0)),
      ],
    );
  }

  Widget textButton(BuildContext context) {
    return TextButton(
      onPressed: func ?? () => textButtonAction(context),
      child: AutoSizeText(
        getButtonText(type),
        style: type == 'forgotPass'
            ? context.headline6.copyWith(
                color: context.accentColor,
                fontWeight: FontWeight.w500,
              )
            : context.headline5.copyWith(
                fontWeight: FontWeight.bold, color: context.accentColor),
      ),
    );
  }

  void textButtonAction(BuildContext context) {
    if (type == 'not_received_code') {
      AuthFunctions.instance.forgotPassword(email!, context);
    } else if (type == 'backToLogin' || type == 'backToSettings') {
      Navigator.of(context).pop();
    } else {
      NavigationService.instance.navigateToPage(
        path: getPath(type),
      );
    }
  }

  String getPath(String type) {
    if (type == 'has_account') {
      return NavigationConstants.login;
    } else if (type == 'has_not_account') {
      return NavigationConstants.register;
    } else {
      return NavigationConstants.forgotPassword;
    }
  }

  String getButtonText(String type) {
    if (type == 'has_account') {
      return 'login'.translate;
    } else if (type == 'has_not_account') {
      return 'register'.translate;
    } else if (type == 'backToLogin') {
      return 'back_login'.translate;
    } else if (type == 'not_received_code') {
      return 'send_again'.translate;
    } else if (type == 'backToSettings') {
      return 'back_to_settings'.translate;
    } else {
      return 'forgot_password_question'.translate;
    }
  }
}
