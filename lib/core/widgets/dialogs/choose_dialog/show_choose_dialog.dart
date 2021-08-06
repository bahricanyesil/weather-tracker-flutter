import 'package:flutter/material.dart';

import '../../../core_shelf.dart';
import 'choose_dialog.dart';
import 'multiple_choose_dialog.dart';

void showChooseDialog(context, title, initialValue, setValue, list,
    bool isMultiple, Function() save,
    {List<String> initialSelected = const []}) {
  Widget infoChooseChild = isMultiple
      ? MultipleChooseDialog(
          title: title,
          setValue: setValue,
          list: list,
          enableSearch: true,
          save: save,
          initialSelected: initialSelected,
        )
      : InfoChooseDialog(
          title: title,
          value: initialValue,
          setValue: setValue,
          list: list,
        );
  showModalBottomSheet(
    context: context,
    builder: (context) => isMultiple
        ? infoChooseChild
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.only(
                left: context.width * 3,
                top: context.width * 3,
                right: context.width * 3,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: infoChooseChild,
            ),
          ),
  );
}
