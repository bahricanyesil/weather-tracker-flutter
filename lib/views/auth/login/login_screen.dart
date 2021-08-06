import 'package:flutter/material.dart';
import '../../../core/core_shelf.dart';
import '../auth_shelf.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';
  bool _visible = false;
  bool _triedExit = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: customOnWillPop,
      child: SafeArea(
        child: getScaffold(),
      ),
    );
  }

  Widget getScaffold() {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if (Utils.instance.getDeviceType(context, constraints) ==
            DeviceType.mobile) {
          return scrollContent();
        } else {
          return getColumn(true);
        }
      }),
    );
  }

  Widget scrollContent() {
    return Padding(
      padding: EdgeInsets.only(
        top: context.height * 4,
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: context.height * 86),
          child: getColumn(false),
        ),
      ),
    );
  }

  Widget getColumn(bool isWeb) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          sized(3),
          Expanded(flex: 3, child: 'welcome_login'.pngImageAsset),
          sized(isWeb ? 5 : 2),
          welcomeText(isWeb),
          sized(isWeb ? 0 : 4),
          textFields(isWeb),
          sized(2),
          loginButton(isWeb),
          sized(3),
          const Expanded(flex: 2, child: HasOrNotAccount('has_not_account')),
        ],
      ),
    );
  }

  Widget textFields(bool isWeb) {
    return Expanded(
      flex: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textField('email', isWeb),
          sized(isWeb ? 1.2 : 0),
          textField('password', isWeb),
          sized(.4),
          const HasOrNotAccount('forgotPass',
              mainAxisAlignment: MainAxisAlignment.end),
        ],
      ),
    );
  }

  Widget welcomeText(bool isWeb) {
    return Expanded(
      flex: 2,
      child: AutoSizeText(
        'welcome'.translate,
        style: context.headline1.copyWith(fontSize: isWeb ? 50 : 40),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget sized(double factor) => SizedBox(height: context.height * factor);

  Widget textField(String type, bool isWeb) {
    return Container(
      width: context.width * (isWeb ? 30 : 75),
      padding: context.topMedium,
      child: RoundedTextButton(
        onChanged: type == 'email' ? _changeEmail : _changePass,
        visibility: type == 'email' ? true : _visible,
        changeVisibility: _changeVisibility,
        hintTextKey: type,
        prefixIcon: type == 'email' ? Icons.email_outlined : Icons.lock_outline,
        isWeb: isWeb,
      ),
    );
  }

  Widget loginButton(bool isWeb) {
    return Expanded(
      flex: 2,
      child: Container(
        width: context.width * (isWeb ? 13 : 45),
        margin: isWeb
            ? EdgeInsets.only(top: context.height * 4)
            : context.topMedium,
        child: RoundedButton(
          buttonTextKey: 'login',
          action: () =>
              AuthFunctions.instance.login(_email, _password, context),
          borderRadius: BorderRadius.circular(isWeb ? 55 : 40),
          backgroundColor: context.accentColor,
          borderColor: context.canvasColor,
          borderWidth: 4,
          textStyle: isWeb ? context.headline2.copyWith(fontSize: 32) : null,
        ),
      ),
    );
  }

  void _changeEmail(String newEmail) {
    setState(() {
      _email = newEmail;
    });
  }

  void _changePass(String newPass) {
    setState(() {
      _password = newPass;
    });
  }

  void _changeVisibility() {
    setState(() {
      _visible = !_visible;
    });
  }

  Future<bool> customOnWillPop() async {
    _triedExit = !_triedExit;
    if (!_triedExit) return true;
    return false;
  }
}
