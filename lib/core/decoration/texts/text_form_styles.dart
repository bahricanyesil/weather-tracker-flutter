import 'package:flutter/material.dart';

import '../../core_shelf.dart';

class TextFormDeco {
  static final TextFormDeco _instance = TextFormDeco();
  static TextFormDeco get instance => _instance;

  InputDecoration loginDeco(BuildContext context, String hintTextKey,
      IconData prefixIcon, bool isWeb) {
    return InputDecoration(
      filled: true,
      fillColor: context.canvasColor,
      contentPadding: EdgeInsets.symmetric(
        horizontal: context.width,
        vertical: context.height * (isWeb ? 3 : 2),
      ),
      hintText: hintTextKey.translate,
      hintStyle: context.headline5.copyWith(
        color: context.primaryDarkColor,
        fontSize: isWeb ? 26 : 16,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: context.extremeCircular,
        borderSide: const BorderSide(width: .5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: context.extremeCircular,
        borderSide: const BorderSide(width: 1.1),
      ),
      prefixIcon: Padding(
        padding: EdgeInsets.only(
          left: context.width * (isWeb ? 1.5 : 2),
          right: context.width * (isWeb ? 1 : 1.5),
        ),
        child: Icon(
          prefixIcon,
          color: context.primaryDarkColor,
          size: context.height * (isWeb ? 4 : 3.3),
        ),
      ),
    );
  }

  InputDecoration textEditDeco(BuildContext context, String hintTextKey) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: context.height)
          .copyWith(left: context.width * 5),
      hintText: hintTextKey.translate,
      hintStyle: context.headline5
          .copyWith(color: context.primaryDarkColor, fontSize: 16),
      enabledBorder: UnderlineInputBorder(
        borderRadius: context.extremeCircular,
        borderSide: BorderSide(
            width: 1, color: context.primaryLightColor.withOpacity(.8)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderRadius: context.extremeCircular,
        borderSide: BorderSide(width: 3, color: context.accentColor),
      ),
    );
  }

  InputDecoration codeDeco(BuildContext context) {
    return InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: context.height * 3),
      enabledBorder: OutlineInputBorder(
        borderRadius: context.mediumCircular,
        borderSide: BorderSide(color: context.primaryLightColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: context.medHighCircular,
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
      counterText: '',
    );
  }

  InputDecoration searchCardDeco(BuildContext context) {
    return InputDecoration(
      hintText: 'search_friend'.translate,
      hintStyle: context.headline6.copyWith(color: context.primaryDarkColor),
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
    );
  }
}
