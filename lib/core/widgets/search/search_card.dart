import 'package:flutter/material.dart';

import '../../core_shelf.dart';

class SearchCard extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) search;
  const SearchCard({required this.controller, required this.search, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.canvasColor,
      shadowColor: Colors.black54,
      elevation: 4,
      shape: BoxDecorations.instance.roundedStyle(context),
      margin: context.mediumEdgeInsets,
      child: getContent(context, controller, search),
    );
  }

  Widget getContent(BuildContext context, TextEditingController controller,
      Function(String) search) {
    return Row(
      children: [
        SizedBox(width: context.width * 3),
        Icon(Icons.search,
            size: context.height * 4, color: context.accentColor),
        Flexible(
          child: Padding(
            padding: context.horizontalMedium,
            child: textField(context),
          ),
        ),
      ],
    );
  }

  Widget textField(BuildContext context) {
    return TextField(
      controller: controller,
      style: context.headline5,
      decoration: TextFormDeco.instance.searchCardDeco(context),
      textInputAction: TextInputAction.search,
      onSubmitted: search,
    );
  }
}
