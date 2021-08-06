import 'package:flutter/material.dart';
import '../../../core/core_shelf.dart';
import '../auth_shelf.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String _oldPassword = '';
  String _newPassword = '';
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(context, 'change_password'),
        body: scrollContent(),
      ),
    );
  }

  Widget scrollContent() {
    return Padding(
      padding: EdgeInsets.only(top: context.height * 4),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: context.height * 80),
          child: getColumn(),
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
          const Spacer(),
          Expanded(flex: 5, child: 'change_password'.pngImageAsset),
          sized(2),
          changePassText(),
          sized(2),
          textFields(),
          loginButton(),
          sized(2),
          const Expanded(child: HasOrNotAccount('backToSettings')),
          const Spacer(),
        ],
      ),
    );
  }

  Widget changePassText() {
    return AutoSizeText(
      'change_pass_description'.translate,
      style: context.headline5,
      textAlign: TextAlign.center,
    );
  }

  Widget textFields() {
    return Expanded(
      flex: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textField('old_password'),
          textField('new_password'),
        ],
      ),
    );
  }

  Widget welcomeText() {
    return Expanded(
      flex: 2,
      child: AutoSizeText(
        'welcome'.translate,
        style: context.headline1.copyWith(fontSize: 40),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget sized(double factor) => SizedBox(height: context.height * factor);

  Widget textField(String type) {
    return Container(
      width: context.width * 75,
      padding: context.topMedium,
      child: RoundedTextButton(
        onChanged:
            type == 'old_password' ? _changeOldPassword : _changeNewPassword,
        visibility: _visible,
        changeVisibility: _changeVisibility,
        hintTextKey: type,
        prefixIcon: Icons.lock_outline,
        isWeb: false,
      ),
    );
  }

  Widget loginButton() {
    return Expanded(
      flex: 2,
      child: Container(
        width: context.width * 45,
        margin: context.topMedium,
        child: RoundedButton(
          buttonTextKey: 'change',
          action: () => AuthFunctions.instance
              .changePassword(_oldPassword, _newPassword, context),
          borderRadius: BorderRadius.circular(40),
          backgroundColor: context.accentColor,
          borderColor: context.canvasColor,
          borderWidth: 4,
        ),
      ),
    );
  }

  void _changeOldPassword(String oldPassword) {
    setState(() {
      _oldPassword = oldPassword;
    });
  }

  void _changeNewPassword(String newPass) {
    setState(() {
      _newPassword = newPass;
    });
  }

  void _changeVisibility() {
    setState(() {
      _visible = !_visible;
    });
  }
}
