import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core_shelf.dart';

class Utils {
  static final Utils _instance = Utils();
  static Utils get instance => _instance;

  void textDialog(BuildContext context, String textKey, {String? text}) {
    final isWeb = getDeviceType(context, null) == DeviceType.web;
    CustomDialog(
      content: Padding(
        padding: isWeb
            ? context.lowEdgeInsets.copyWith(top: context.height * 2)
            : const EdgeInsets.all(0),
        child: Text(
          text ?? textKey.translate,
          textAlign: TextAlign.center,
          style: context.headline5.copyWith(
            fontSize: (context.width + context.height) / (isWeb ? 1.1 : .76),
          ),
        ),
      ),
    ).show(context);
  }

  DeviceType getDeviceType(BuildContext context, BoxConstraints? constraints) {
    final orientation = MediaQuery.of(context).orientation;
    var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.height;
    if (constraints != null) {
      maxWidth = constraints.maxWidth;
      maxHeight = constraints.maxHeight;
    }
    if ((orientation == Orientation.portrait && maxWidth < 600) ||
        (orientation == Orientation.landscape && maxHeight < 600)) {
      return DeviceType.mobile;
    } else {
      return DeviceType.web;
    }
  }

  Future<void> urlHelper(url) async {
    if (url == '' || url == null) return;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String weekdayName(DateTime date) {
    final days = [
      '',
      'monday'.translate,
      'tuesday'.translate,
      'wednesday'.translate,
      'thursday'.translate,
      'friday'.translate,
      'saturday'.translate,
      'sunday'.translate
    ];
    return days[date.weekday];
  }

  String getTime(BuildContext context, DateTime date) {
    final isTurkish = Localizations.localeOf(context).languageCode == 'tr';
    return isTurkish
        ? DateFormat('Hm').format(date)
        : DateFormat('hh:mm a').format(date);
  }

  String getDayMonth(DateTime date) {
    final months = [
      '',
      'january'.translate,
      'february'.translate,
      'march'.translate,
      'april'.translate,
      'may'.translate,
      'june'.translate,
      'july'.translate,
      'august'.translate,
      'september'.translate,
      'october'.translate,
      'november'.translate,
      'december'.translate
    ];
    return '${date.day} ${months[date.month]}';
  }

  bool errorDialogHelper(provider, BuildContext context, [shouldPop]) {
    if (provider.errorMessage == '') {
      return true;
    } else {
      if (shouldPop != null && shouldPop) Navigator.of(context).pop();
      Utils.instance.textDialog(context, '', text: provider.errorMessage);
      provider.errorMessage = '';
      return false;
    }
  }
}
