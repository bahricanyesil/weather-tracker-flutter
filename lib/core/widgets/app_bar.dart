import 'package:flutter/material.dart';

import '../core_shelf.dart';

PreferredSize getAppBar(BuildContext context, String titleKey) {
  return PreferredSize(
    preferredSize: Size.fromHeight(context.height * 8),
    child: AppBar(
      backgroundColor: context.accentColor.withOpacity(.4),
      brightness: Brightness.light,
      flexibleSpace: mainContainer(context, titleKey),
      automaticallyImplyLeading: false,
    ),
  );
}

Widget mainContainer(BuildContext context, String titleKey) {
  return SafeArea(
    child: Row(
      children: [
        Expanded(child: logo(context)),
        screenText(context, titleKey),
        Expanded(child: Container())
      ],
    ),
  );
}

Widget screenText(BuildContext context, String titleKey) {
  return Align(
    alignment: Alignment.center,
    child: Padding(
      padding: context.leftMedHigh,
      child: AutoSizeText(
        titleKey.translate,
        style: context.headline3.copyWith(fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget logo(BuildContext context) {
  return Align(
    alignment: Alignment.topLeft,
    child: Padding(
      padding: context.leftMedHigh.copyWith(top: context.height),
      child: 'logo'.pngLogoAsset,
    ),
  );
}
