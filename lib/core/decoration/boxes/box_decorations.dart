import 'package:flutter/material.dart';

import '../../core_shelf.dart';

class BoxDecorations {
  static final BoxDecorations _instance = BoxDecorations();
  static BoxDecorations get instance => _instance;

  ShapeBorder roundedStyle(BuildContext context,
      {Color? borderColor, BorderRadius? borderRadius, double? borderWidth}) {
    return RoundedRectangleBorder(
      borderRadius: borderRadius ?? context.highCircular,
      side: BorderSide(
        color: borderColor ?? context.accentColor.withOpacity(.7),
        width: borderWidth ?? 1.8,
      ),
    );
  }

  ShapeBorder sharpDeco(BuildContext context) {
    return RoundedRectangleBorder(
      borderRadius: context.mediumCircular,
      side: BorderSide(color: context.accentColor.withOpacity(.7), width: 1.5),
    );
  }

  BoxDecoration settingsItemDeco(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(context.width * 3),
      color: context.primaryDarkColor.withOpacity(.12),
    );
  }

  BoxDecoration roundedDeco(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: context.canvasColor.withOpacity(.7),
      border: Border.all(color: context.accentColor.withOpacity(.7), width: 2),
    );
  }
}
