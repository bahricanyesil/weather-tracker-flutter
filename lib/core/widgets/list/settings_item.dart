import 'package:flutter/material.dart';

import '../../../core/core_shelf.dart';

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String? text;
  final bool hasNavigation;
  final bool switchType;
  final Function? function;

  const SettingsItem(
      {Key? key,
      required this.icon,
      this.text,
      this.hasNavigation = true,
      this.switchType = false,
      this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return function != null
        ? GestureDetector(
            onTap: function as void Function()?,
            child:
                mainBody(switchType, context, icon, hasNavigation, text ?? ''),
          )
        : mainBody(switchType, context, icon, hasNavigation, text ?? '');
  }

  Widget mainBody(
    bool switchType,
    BuildContext context,
    IconData icon,
    bool hasNavigation,
    String text,
  ) {
    return Container(
      height: context.height * 10,
      margin: EdgeInsets.symmetric(horizontal: context.width * 6)
          .copyWith(bottom: context.height * 2),
      padding: EdgeInsets.only(
          left: context.width * 4, right: switchType ? 0 : context.width * 5),
      decoration: BoxDecorations.instance.settingsItemDeco(context),
      child: Row(
        children: <Widget>[
          getIcon(icon, context),
          SizedBox(width: context.width * 3),
          getText(text, context),
          const Spacer(),
          if (hasNavigation)
            Icon(
              Icons.arrow_forward_ios,
              size: context.width * 6,
              color: Colors.white,
            ),
          SizedBox(width: context.width)
        ],
      ),
    );
  }

  Widget getIcon(IconData icon, BuildContext context) {
    return Icon(
      icon,
      size: context.width * 6,
      color: context.accentColor,
    );
  }

  Widget getText(String text, BuildContext context) {
    return AutoSizeText(text, style: context.headline5);
  }
}
