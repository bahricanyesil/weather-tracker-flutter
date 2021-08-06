import 'package:flutter/material.dart';

import '../../../core/core_shelf.dart';
import '../auth_shelf.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, 'forgot_password'),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: context.height * 4, horizontal: context.width * 2),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: context.height * 80),
            child: getColumn(),
          ),
        ),
      ),
    );
  }

  Widget getColumn() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          sized(3),
          Expanded(flex: 6, child: 'forgot_password'.pngImageAsset),
          sized(2),
          forgotPassText(),
          sized(2),
          textField(),
          sendVerificationButton(),
          sized(2),
          const Expanded(child: HasOrNotAccount('backToLogin')),
          const Spacer(),
        ],
      ),
    );
  }

  Widget forgotPassText() {
    return AutoSizeText(
      'forgot_pass_description'.translate,
      style: context.headline5,
      textAlign: TextAlign.center,
    );
  }

  Widget textField() {
    return Expanded(
      flex: 2,
      child: Container(
        width: context.width * 75,
        padding: context.topMedium,
        child: RoundedTextButton(
          onChanged: _changeEmail,
          hintTextKey: 'email',
          prefixIcon: Icons.email_outlined,
        ),
      ),
    );
  }

  Widget sendVerificationButton() {
    return Expanded(
      flex: 2,
      child: Container(
        width: context.width * 45,
        margin: context.topMedium,
        child: RoundedButton(
          buttonTextKey: 'send_mail',
          action: () => AuthFunctions.instance.forgotPassword(_email, context),
          borderRadius: BorderRadius.circular(40),
          backgroundColor: context.accentColor,
          borderColor: context.canvasColor,
          borderWidth: 4,
        ),
      ),
    );
  }

  void _changeEmail(String newEmail) {
    setState(() {
      _email = newEmail;
    });
  }

  Widget sized(double factor) => SizedBox(height: context.height * factor);
}
