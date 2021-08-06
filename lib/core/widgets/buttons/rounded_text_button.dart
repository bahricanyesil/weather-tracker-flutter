import 'package:flutter/material.dart';

import '../../core_shelf.dart';

class RoundedTextButton extends StatelessWidget {
  final Function(String) onChanged;
  final String hintTextKey;
  final IconData prefixIcon;
  final bool visibility;
  final bool isWeb;
  final Function()? changeVisibility;
  const RoundedTextButton({
    required this.onChanged,
    this.hintTextKey = '',
    required this.prefixIcon,
    this.visibility = false,
    this.changeVisibility,
    this.isWeb = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: isWeb ? 26 : 16),
      decoration: hintTextKey.contains('password')
          ? passDeco(context)
          : TextFormDeco.instance
              .loginDeco(context, hintTextKey, prefixIcon, isWeb),
      onChanged: onChanged,
      obscureText:
          hintTextKey.contains('password') && !visibility ? true : false,
    );
  }

  InputDecoration passDeco(BuildContext context) {
    return TextFormDeco.instance
        .loginDeco(context, hintTextKey, prefixIcon, isWeb)
        .copyWith(
          suffixIcon: Padding(
            padding: context.rightMedium
                .copyWith(bottom: isWeb ? context.height * 1.6 : 0),
            child: IconButton(
              splashRadius: 20,
              icon: Icon(
                visibility
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: context.primaryDarkColor,
                size: context.height * (isWeb ? 4.2 : 3.3),
              ),
              onPressed: changeVisibility ?? () {},
            ),
          ),
        );
  }
}
