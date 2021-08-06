import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../core_shelf.dart';

class MultipleChooseDialog extends StatefulWidget {
  final List<String> list;
  final bool enableSearch;
  final Function setValue;
  final String title;
  final List<String> initialSelected;
  final Function() save;
  const MultipleChooseDialog(
      {required this.list,
      this.enableSearch = false,
      required this.setValue,
      required this.title,
      required this.save,
      this.initialSelected = const [],
      Key? key})
      : super(key: key);

  @override
  _MultipleChooseDialogState createState() => _MultipleChooseDialogState();
}

class _MultipleChooseDialogState extends State<MultipleChooseDialog> {
  List<String> localList = [];
  String text = '';
  List<String> selectedValues = [];

  @override
  void initState() {
    super.initState();
    selectedValues = [...widget.initialSelected];
  }

  @override
  Widget build(BuildContext context) {
    localList = widget.list;
    if (text != '' && widget.enableSearch) {
      localList = localList
          .where(
              (element) => element.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
    return Padding(
      padding: context.mediumEdgeInsets,
      child: Stack(
        children: [
          mainList(),
          okButton(),
        ],
      ),
    );
  }

  Widget mainList() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.only(
          left: context.width * 3,
          top: context.width * 3,
          right: context.width * 3,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mainText(context),
            SizedBox(height: context.height * 2),
            widget.enableSearch ? getSearchForm(context) : Container(),
            SizedBox(height: context.height * 3),
            getList(context),
            SizedBox(height: context.height * 2),
          ],
        ),
      ),
    );
  }

  Widget okButton() {
    return Positioned(
      right: context.height * 2,
      bottom: context.height * 1.5,
      child: TextButton(
        onPressed: widget.save,
        child: AutoSizeText(
          'OK'.translate,
          style: context.headline5.copyWith(color: context.accentColor),
        ),
      ),
    );
  }

  Widget mainText(BuildContext context) {
    return AutoSizeText(
      widget.title,
      style: context.headline4.copyWith(color: context.accentColor),
    );
  }

  Widget getList(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: localList.length > 30 ? 30 : localList.length,
      itemBuilder: getSheetElement,
    );
  }

  Widget getSheetElement(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(top: context.height),
      child: Row(
        children: [
          Checkbox(
            activeColor: Theme.of(context).accentColor,
            value: selectedValues.contains(localList[index]),
            onChanged: (val) => _handleValueChange(index),
          ),
          GestureDetector(
            onTap: () => _handleValueChange(index),
            child: AutoSizeText(localList[index], style: context.headline6),
          ),
        ],
      ),
    );
  }

  Widget getSearchForm(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: context.primaryLightColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: context.accentColor),
          ),
          hintStyle:
              context.headline6.copyWith(color: context.primaryDarkColor),
          contentPadding: context.leftLow,
          hintText: 'search'.translate),
      style: context.headline6,
      onChanged: (val) {
        setState(() {
          text = val;
        });
      },
    );
  }

  void _handleValueChange(int index) {
    setState(() {
      if (selectedValues.contains(localList[index])) {
        selectedValues.remove(localList[index]);
      } else {
        selectedValues.add(localList[index]);
      }
      widget.setValue(selectedValues);
    });
  }
}
