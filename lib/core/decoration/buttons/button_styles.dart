import 'package:flutter/material.dart';

import '../../core_shelf.dart';

class ButtonStyles {
  static final ButtonStyles _instance = ButtonStyles();
  static ButtonStyles get instance => _instance;

  ButtonStyle roundedStyle(
    BuildContext context, {
    Color? backgroundColor,
    Color? borderColor,
    BorderRadius? borderRadius,
    required double borderWidth,
  }) {
    return ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all(backgroundColor ?? context.canvasColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: borderRadius ?? context.highCircular,
          side: BorderSide(
              color: borderColor ?? context.primaryColor, width: borderWidth),
        ),
      ),
    );
  }

  ButtonStyle sharpStyle(BuildContext context, {BorderRadius? radius}) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(context.canvasColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: radius ?? context.lowCircular,
          side: BorderSide(color: context.accentColor, width: 1.5),
        ),
      ),
    );
  }
}
