import 'package:flutter/material.dart';

import '../../core_shelf.dart';

class MeetingListItem extends StatelessWidget {
  final MeetingModel meeting;
  final Function(MeetingModel) edit;
  const MeetingListItem({Key? key, required this.meeting, required this.edit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: getLeading(context, meeting.city),
      title: AutoSizeText(meeting.city),
      subtitle: AutoSizeText(meeting.country),
      trailing: IconButton(
        onPressed: () => edit(meeting),
        splashRadius: context.width * 7,
        icon: Icon(Icons.edit_outlined, color: context.accentColor),
      ),
    );
  }

  Widget getLeading(BuildContext context, String city) {
    return SizedBox(
      width: context.width * 13,
      child: Image.asset(
        city.toLowerCase() == 'istanbul'
            ? 'assets/images/sunny.png'
            : 'assets/images/clouds.png',
        alignment: Alignment.center,
        fit: BoxFit.contain,
      ),
    );
  }
}
