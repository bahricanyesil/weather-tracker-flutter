import 'package:flutter/material.dart';
import '../../../core/core_shelf.dart';
import '../auth_shelf.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _email = '';
  String _password = '';
  String _confirmPass = '';
  String _username = '';
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
          constraints: BoxConstraints(maxHeight: context.height * 88),
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
          sized(isWeb ? 10 : 1),
          Expanded(flex: 4, child: 'welcome'.pngImageAsset),
          sized(isWeb ? 5 : 2),
          welcomeText(isWeb),
          textFields(isWeb),
          sized(2),
          loginButton(isWeb),
          sized(1),
          const Expanded(flex: 2, child: HasOrNotAccount('has_account')),
        ],
      ),
    );
  }

  Widget textFields(bool isWeb) {
    return Expanded(
      flex: 9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textField('username', isWeb),
          sized(isWeb ? 1.2 : 0),
          textField('email', isWeb),
          sized(isWeb ? 1.2 : 0),
          textField('password', isWeb),
          sized(isWeb ? 1.2 : 0),
          textField('confirm_password', isWeb),
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
        onChanged: getFunction(type),
        visibility: type == 'email' ? true : _visible,
        changeVisibility: _changeVisibility,
        hintTextKey: type,
        prefixIcon: type == 'email' ? Icons.email_outlined : Icons.lock_outline,
        isWeb: isWeb,
      ),
    );
  }

  Function(String) getFunction(String type) {
    if (type == 'email') {
      return _changeEmail;
    } else if (type == 'username') {
      return _changeUsername;
    } else if (type == 'password') {
      return _changePass;
    } else {
      return _changeConfirmPassword;
    }
  }

  Widget loginButton(bool isWeb) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: EdgeInsets.only(top: context.height * .7),
        width: context.width * (isWeb ? 13 : 45),
        child: RoundedButton(
          buttonTextKey: 'register',
          action: () => AuthFunctions.instance
              .register(_email, _password, _confirmPass, _username, context),
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

  void _changeConfirmPassword(String newConfirmPass) {
    setState(() {
      _confirmPass = newConfirmPass;
    });
  }

  void _changeUsername(String newUsername) {
    setState(() {
      _username = newUsername;
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
