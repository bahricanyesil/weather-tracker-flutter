import 'package:flutter/material.dart';

import '../../core_shelf.dart';

class EditText extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const EditText({Key? key, required this.hintText, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.verticalLow,
      child: TextFormField(
        decoration: TextFormDeco.instance.textEditDeco(context, hintText),
        controller: controller,
      ),
    );
  }
}
