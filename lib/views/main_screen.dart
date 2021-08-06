import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../core/core_shelf.dart';
import 'views_shelf.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 1;
  final GlobalKey _bottomNavigationKey = GlobalKey();

  Future<bool> setInitial() async {
    if (pageIndex == 1) {
      final meetingProvider =
          Provider.of<MeetingProvider>(context, listen: false);
      await meetingProvider.getWeather("1");
      if (Utils.instance.errorDialogHelper(meetingProvider, context)) {}
    } else if (pageIndex == 0) {
      final friendProvider =
          Provider.of<FriendProvider>(context, listen: false);
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      // await friendProvider.getRequestAndFriends(userProvider.user.uniqueId);
      if (Utils.instance.errorDialogHelper(friendProvider, context)) {}
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setInitial(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: appbarWithTitle(),
                bottomNavigationBar: getNavigationBar(),
                body: getScreen(),
              )
            : Center(
                child: CircularProgressIndicator(color: context.accentColor));
      },
    );
  }

  Widget getScreen() {
    if (pageIndex == 0) {
      return const SearchScreen();
    } else if (pageIndex == 2) {
      return SettingsScreen();
    } else {
      return const HomeScreen();
    }
  }

  Widget getNavigationBar() {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      backgroundColor: context.primaryColor,
      color: context.accentColor.withOpacity(.4),
      height: context.height * 8 >= 74 ? 74 : context.height * 8,
      index: pageIndex,
      animationDuration: context.fast,
      items: getBarItems(),
      onTap: navigationBarAction,
    );
  }

  List<Widget> getBarItems() {
    return <Widget>[
      defaultIcon(Icons.search_outlined, 0),
      defaultIcon(Icons.home_outlined, 1),
      defaultIcon(Icons.settings_outlined, 2),
    ];
  }

  Widget defaultIcon(IconData iconData, int index) {
    return Padding(
      padding: pageIndex == index ? const EdgeInsets.all(0) : context.topLow,
      child: Icon(
        iconData,
        size: context.width * 9,
        color: pageIndex == index ? Colors.white : Colors.white70,
      ),
    );
  }

  PreferredSize appbarWithTitle() {
    var titleKey = 'home_screen';
    if (pageIndex == 0) {
      titleKey = 'search_screen';
    } else if (pageIndex == 2) {
      titleKey = 'settings_screen';
    }
    return getAppBar(context, titleKey);
  }

  void navigationBarAction(int index) {
    setState(() {
      pageIndex = index;
    });
  }
}
