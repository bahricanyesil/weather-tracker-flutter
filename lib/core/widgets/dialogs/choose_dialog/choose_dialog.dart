import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../core_shelf.dart';

class InfoChooseDialog extends StatefulWidget {
  final String value;
  final String title;
  final Function setValue;
  final List<String> list;
  final bool showButtons;
  final bool enableSearch;
  const InfoChooseDialog(
      {required this.setValue,
      required this.value,
      required this.list,
      this.showButtons = true,
      this.enableSearch = false,
      required this.title,
      Key? key})
      : super(key: key);

  @override
  _InfoChooseDialogState createState() => _InfoChooseDialogState();
}

class _InfoChooseDialogState extends State<InfoChooseDialog> {
  var _radioValue;
  String text = '';
  List<String> localList = [];

  @override
  void initState() {
    var index = widget.list.indexWhere((element) => element == widget.value);
    if (index != -1) {
      _radioValue = index;
    }
    super.initState();
  }

  void _handleRadioValueChange(val) {
    widget.setValue(localList[val]);
    setState(() {
      _radioValue = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    localList = widget.list;
    if (text != '' && widget.enableSearch) {
      localList = localList
          .where(
              (element) => element.toLowerCase().contains(text.toLowerCase()))
          .toList();
      if (localList.isNotEmpty && _radioValue != null) {
        if (localList.length > _radioValue) {
          widget.setValue(localList[_radioValue]);
        } else {
          widget.setValue(localList[0]);
          setState(() {
            _radioValue = 0;
          });
        }
      }
    }
    return Padding(
      padding: context.mediumEdgeInsets,
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
    );
  }

  Widget mainText(BuildContext context) {
    return AutoSizeText(
      widget.title,
      style: Theme.of(context).textTheme.headline3,
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
          Radio(
            activeColor: Theme.of(context).accentColor,
            value: index,
            groupValue: _radioValue,
            onChanged: (val) => _handleRadioValueChange(index),
          ),
          GestureDetector(
            onTap: () => _handleRadioValueChange(index),
            child: Text(
              localList[index],
              style: context.headline6,
            ),
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
        hintStyle: context.headline6,
        contentPadding: context.leftLow,
        hintText: 'search'.translate,
      ),
      style: context.headline6.copyWith(color: Colors.black87),
      onChanged: (val) {
        setState(() {
          text = val;
        });
      },
    );
  }

  void onPressed() {
    widget.setValue(localList[_radioValue]);
  }
}
