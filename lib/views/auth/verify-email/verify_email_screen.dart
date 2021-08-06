import 'dart:async';

import 'package:flutter/material.dart';
import '../../../core/core_shelf.dart';
import '../auth_shelf.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;
  const VerifyEmailScreen({required this.email, Key? key}) : super(key: key);

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  String email = '';
  int counter = 150;
  late final Timer _timer;

  void timerFunc(Timer timer) {
    if (counter == 0) {
      setState(() {
        timer.cancel();
      });
    } else {
      setState(() {
        counter--;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    email = widget.email;
    counter = 150;
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (timer) {
        if (counter == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            counter--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, 'verify_email'),
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
          Expanded(flex: 6, child: 'verify_email'.pngImageAsset),
          sized(2),
          enterCodeText(),
          sized(2),
          getTextBoxes(),
          sized(2),
          remainingTime(),
          sized(2),
          notReceivedCode(),
          verifyButton(),
          sized(2),
          const Spacer(),
        ],
      ),
    );
  }

  Widget notReceivedCode() {
    return HasOrNotAccount(
      'not_received_code',
      email: email,
      func: () => setState(() {
        counter = 150;
      }),
    );
  }

  Widget remainingTime() {
    var stringMin = '';
    var stringSec = '';
    var minutes = counter ~/ 60;
    stringMin = minutes < 10 ? '0$minutes' : minutes.toString();
    var seconds = counter % 60;
    stringSec = seconds < 10 ? '0$seconds' : seconds.toString();
    return AutoSizeText('$stringMin:$stringSec', textAlign: TextAlign.center);
  }

  Widget getTextBoxes() {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: context.horizontalHigh,
        child: Row(
          children: [
            textbox(_controllers[0], context),
            Expanded(child: Container()),
            textbox(_controllers[1], context),
            Expanded(child: Container()),
            textbox(_controllers[2], context),
            Expanded(child: Container()),
            textbox(_controllers[3], context),
          ],
        ),
      ),
    );
  }

  Widget textbox(TextEditingController controller, BuildContext context) {
    return Expanded(
      flex: 4,
      child: TextField(
        onChanged: (value) {
          if (value.length == 1) FocusScope.of(context).nextFocus();
        },
        style: context.headline5.copyWith(fontWeight: FontWeight.bold),
        textInputAction: TextInputAction.next,
        maxLength: 1,
        keyboardType: TextInputType.number,
        controller: controller,
        textAlign: TextAlign.center,
        decoration: TextFormDeco.instance.codeDeco(context),
      ),
    );
  }

  Widget enterCodeText() {
    return Expanded(
      flex: 2,
      child: Column(children: [
        AutoSizeText(
          'enter_verification_code'.translate,
          style: context.headline4,
        ),
        sized(2),
        AutoSizeText(
          email,
          style: context.headline6.copyWith(color: context.primaryDarkColor),
        )
      ]),
    );
  }

  Widget verifyButton() {
    return Expanded(
      flex: 3,
      child: Container(
        width: context.width * 45,
        margin: context.topMedium,
        child: RoundedButton(
          buttonTextKey: 'send_mail',
          action: () {
            if (counter > 0) {
              _timer.cancel();
              AuthFunctions.instance.verifyEmail(email, getCode(), context);
            }
          },
          borderRadius: BorderRadius.circular(40),
          backgroundColor:
              counter > 0 ? context.accentColor : context.primaryDarkColor,
          borderColor: context.canvasColor,
          borderWidth: 4,
        ),
      ),
    );
  }

  String getCode() {
    return _controllers[0].text +
        _controllers[1].text +
        _controllers[2].text +
        _controllers[3].text;
  }

  Widget sized(double factor) => SizedBox(height: context.height * factor);
}
