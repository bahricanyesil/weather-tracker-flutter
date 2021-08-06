import 'package:flutter/material.dart';
import '../../core/core_shelf.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserModel user;
  late WeatherModel weather;
  final List<TextEditingController> _controllers =
      List.generate(2, (index) => TextEditingController());
  final List<String> _textKeys = ['city', 'country'];
  List<String> selectedUsers = [];

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).user;
    weather = Provider.of<MeetingProvider>(context, listen: false).weather;
    return Padding(
      padding: context.medHighEdgeInsets
          .copyWith(left: context.width * 8, right: context.width * 2),
      child: Column(
        children: [
          getCityCountry(),
          sized(1),
          getDate(),
          imageAndDetails(),
          meetingsTitle(),
          divider(),
          getMeetings(),
        ],
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.only(
        top: context.height,
        right: context.width * 10,
        left: context.width,
      ),
      child: Divider(color: context.primaryDarkColor, thickness: 1),
    );
  }

  Widget meetingsTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        yourMeetingsText(),
        addMeetingButton(),
      ],
    );
  }

  Widget yourMeetingsText() {
    return Padding(
      padding: EdgeInsets.only(left: context.width * 4.2),
      child: AutoSizeText(
        'your_meetings'.translate,
        style: context.headline4
            .copyWith(color: context.accentColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget addMeetingButton() {
    return Padding(
      padding: EdgeInsets.only(right: context.width * 10),
      child: ElevatedButton.icon(
        onPressed: addMeeting,
        style: ButtonStyles.instance
            .sharpStyle(context, radius: context.highCircular),
        label: Text('add'.translate),
        icon: Icon(Icons.add_outlined, color: context.accentColor),
      ),
    );
  }

  void addMeeting({bool isEdit = false, MeetingModel? meeting}) {
    if (isEdit) {
      _controllers[0].text = meeting!.city;
      _controllers[1].text = meeting.country;
    }
    CustomDialog(
      title: Text(
        isEdit ? 'edit_meeting'.translate : 'add_meeting'.translate,
        style: context.headline5,
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(
          2,
          (int index) => EditText(
            controller: _controllers[index],
            hintText: _textKeys[index],
          ),
        ),
      ),
      action: () => saveEditInfo(isEdit, meeting),
    ).show(context);
  }

  Future<void> saveEditInfo(bool isEdit, MeetingModel? meeting) async {
    if (_controllers[0].text.isEmpty || _controllers[1].text.isEmpty) {
      Utils.instance.textDialog(context, 'fill_all_fields');
      return;
    }
    // ignore: omit_local_variable_types
    List<String> userNames = [];
    final friendProv = Provider.of<FriendProvider>(context, listen: false);
    final participanceProv =
        Provider.of<ParticipanceProvider>(context, listen: false);
    // await ServiceUtils.instance.requestHelper(
    //   () {
    //      if(isEdit) {
    //        await participanceProv.getUsersByMeetingId(meeting!.uniqueId);
    //      }
    //      friendProv.getFriendsOfUser(
    //       Provider.of<UserProvider>(context, listen: false).user.uniqueId);
    //    },
    //   context,
    // );
    if (Utils.instance.errorDialogHelper(friendProv, context) &&
        Utils.instance.errorDialogHelper(participanceProv, context)) {
      for (var i = 0; i < friendProv.friendsOfUser.length; i++) {
        userNames.add(friendProv.friendsOfUser[i].userName);
      }
      // ignore: omit_local_variable_types
      List<String> chosenUsers = [];
      if (isEdit) {
        for (var i = 0; i < participanceProv.users.length; i++) {
          chosenUsers.add(participanceProv.users[i].userName);
        }
      }

      showChooseDialog(context, 'choose_friends'.translate, '', setValue,
          userNames, true, save,
          initialSelected: chosenUsers);
    }
  }

  Future<void> save() async {
    if (selectedUsers.isEmpty) {
      Utils.instance.textDialog(context, 'at_least_one_friend');
    } else {
      final meetingProv = Provider.of<MeetingProvider>(context, listen: false);
      final friendProv = Provider.of<FriendProvider>(context, listen: false);
      // ignore: omit_local_variable_types
      List<String> selectedUserIds = [];
      for (var i = 0; i < selectedUsers.length; i++) {
        selectedUserIds.add(friendProv
            .friendsOfUser[friendProv.friendsOfUser
                .indexWhere((element) => element.userName == selectedUsers[i])]
            .uniqueId);
      }
      // await ServiceUtils.instance.requestHelper(
      //   () => meetingProv.createMeeting(
      //     _controllers[0].text,
      //     _controllers[1].text,
      //     selectedUserIds,
      //   ),
      //   context,
      // );
      if (Utils.instance.errorDialogHelper(meetingProv, context)) {
        Navigator.of(context).pop();
      }
    }
  }

  void setValue(List<String> names) {
    setState(() {
      selectedUsers = names;
    });
  }

  Widget getMeetings() {
    final participanceProvider =
        Provider.of<ParticipanceProvider>(context, listen: false);
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: participanceProvider.meetings.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(right: context.width * 6),
            alignment: Alignment.centerLeft,
            child: MeetingListItem(
              meeting: participanceProvider.meetings[index],
              edit: editMeeting,
            ),
          );
        },
      ),
    );
  }

  Future<void> editMeeting(MeetingModel meeting) async {
    addMeeting(isEdit: true, meeting: meeting);
  }

  Widget imageAndDetails() {
    return SizedBox(
      height: context.height * 30,
      child: Row(
        children: [
          getImage(context),
          sizedW(4),
          getDetailColumn(context),
        ],
      ),
    );
  }

  Widget getDetailColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          weather.condition,
          style: context.headline1.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.w500,
            color: context.accentColor,
          ),
          textAlign: TextAlign.center,
        ),
        sized(1),
        AutoSizeText(
          '${weather.temperature} °C',
          style: context.headline1.copyWith(fontSize: 36),
        ),
        sized(1),
        getDetailText(
            '${'wind_speed'.translate}: ${weather.windSpeed} ${'wind_symbol'.translate}'),
        sized(1),
        getDetailText('${'cloud'.translate}: ${weather.cloud}'),
        sized(1),
        getDetailText(
            '${'last_update'.translate}: ${Utils.instance.getDayMonth(weather.lastUpdated)}'),
      ],
    );
  }

  Widget getDetailText(String text) {
    return AutoSizeText(
      text,
      style: context.headline6
          .copyWith(color: context.primaryDarkColor, fontSize: 14),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget getImage(BuildContext context) {
    return SizedBox(
      width: context.width * 40,
      child: Image.asset(
        getImagePath(),
        alignment: Alignment.centerLeft,
        fit: BoxFit.fill,
      ),
    );
  }

  String getImagePath() {
    if (weather.condition.toLowerCase() == 'sunny') {
      return 'assets/images/sunny.png';
    }
    return '';
  }

  Widget getCityCountry() {
    return Row(
      children: [
        AutoSizeText(
          '${user.city}, ',
          style: context.headline2.copyWith(
            fontSize: 38,
            color: context.accentColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        AutoSizeText(
          user.country,
          style: context.headline3.copyWith(fontSize: 27),
        ),
      ],
    );
  }

  Widget getDate() {
    final now = DateTime.now();
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {},
          child: AutoSizeText('today'.translate, style: context.headline6),
          style: ButtonStyles.instance.sharpStyle(context),
        ),
        sizedW(4),
        AutoSizeText(
          '${Utils.instance.weekdayName(now)} ${Utils.instance.getTime(context, now)}',
          style: context.headline6,
        ),
      ],
    );
  }

  Widget sized(double sizeFactor) =>
      SizedBox(height: context.height * sizeFactor);

  Widget sizedW(double sizeFactor) =>
      SizedBox(width: context.width * sizeFactor);
}
