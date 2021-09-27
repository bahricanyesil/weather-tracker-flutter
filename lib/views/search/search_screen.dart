import 'package:flutter/material.dart';
import '../../core/core_shelf.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  bool hasSearched = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 4.2)
          .copyWith(top: context.height * 1.4, bottom: context.height * 2.4),
      child: Column(
        children: [
          SizedBox(
            height: context.height * 10,
            child: SearchCard(controller: _controller, search: search),
          ),
          getUserList(context),
        ],
      ),
    );
  }

  Widget getUserList(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: context.rightLowMed.copyWith(bottom: context.height * 2),
        child: Scrollbar(
          child: Consumer<UserProvider>(
            builder: (context, userProv, child) => getList(userProv),
          ),
        ),
      ),
    );
  }

  Widget getList(UserProvider userProv) {
    final friendProv = Provider.of<FriendProvider>(context, listen: false);
    return !hasSearched && friendProv.friendsOfUser.isEmpty
        ? Center(
            child: AutoSizeText('no_friends'.translate,
                style: context.headline4, textAlign: TextAlign.center),
          )
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: hasSearched
                ? userProv.searchedUsers.length
                : friendProv.friendsOfUser.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                height: context.height * 9.2,
                padding: EdgeInsets.only(top: context.height * .4),
                child: UserListItem(
                  user: hasSearched
                      ? userProv.searchedUsers[index]
                      : friendProv.friendsOfUser[index],
                ),
              );
            },
          );
  }

  Future<void> search(String searchText) async {
    final friendProvider = Provider.of<FriendProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    /// Used dummy data providers since the back-end isn't deployed.
    await ServiceUtils.instance.requestHelper(
      () async {
        var res = await NetworkManager.instance
            .getRequest("https://randomuser.me/api/", 'token');

        UserModel user = UserModel(
            res['results'][0]['name']['first'],
            res['results'][0]['email'],
            res['results'][0]['location']['state'],
            res['results'][0]['location']['city'],
            res['results'][0]['picture']['medium'],
            "2");
        user.imageUrl = res['results'][0]['picture']['medium'];
        userProvider.searchedUsers.add(user);

        res = await NetworkManager.instance
            .getRequest("https://randomuser.me/api/", 'token');
        user = UserModel(
            res['results'][0]['name']['first'],
            res['results'][0]['email'],
            res['results'][0]['location']['state'],
            res['results'][0]['location']['city'],
            res['results'][0]['picture']['medium'],
            "3");
        user.imageUrl = res['results'][0]['picture']['medium'];
        userProvider.searchedUsers.add(user);
        res = await NetworkManager.instance
            .getRequest("https://randomuser.me/api/", 'token');
        user = UserModel(
            res['results'][0]['name']['first'],
            res['results'][0]['email'],
            res['results'][0]['location']['state'],
            res['results'][0]['location']['city'],
            res['results'][0]['picture']['medium'],
            "3");
        user.imageUrl = res['results'][0]['picture']['medium'];
        userProvider.searchedUsers.add(user);
        res = await NetworkManager.instance
            .getRequest("https://randomuser.me/api/", 'token');
        user = UserModel(
            res['results'][0]['name']['first'],
            res['results'][0]['email'],
            res['results'][0]['location']['state'],
            res['results'][0]['location']['city'],
            res['results'][0]['picture']['medium'],
            "3");
        user.imageUrl = res['results'][0]['picture']['medium'];
        userProvider.searchedUsers.add(user);
        res = await NetworkManager.instance
            .getRequest("https://randomuser.me/api/", 'token');
        user = UserModel(
            res['results'][0]['name']['first'],
            res['results'][0]['email'],
            res['results'][0]['location']['state'],
            res['results'][0]['location']['city'],
            res['results'][0]['picture']['medium'],
            "3");
        user.imageUrl = res['results'][0]['picture']['medium'];
        userProvider.searchedUsers.add(user);
        res = await NetworkManager.instance
            .getRequest("https://randomuser.me/api/", 'token');
        user = UserModel(
            res['results'][0]['name']['first'],
            res['results'][0]['email'],
            res['results'][0]['location']['state'],
            res['results'][0]['location']['city'],
            res['results'][0]['picture']['medium'],
            "3");
        user.imageUrl = res['results'][0]['picture']['medium'];
        userProvider.searchedUsers.add(user);
        res = await NetworkManager.instance
            .getRequest("https://randomuser.me/api/", 'token');
        user = UserModel(
            res['results'][0]['name']['first'],
            res['results'][0]['email'],
            res['results'][0]['location']['state'],
            res['results'][0]['location']['city'],
            res['results'][0]['picture']['medium'],
            "3");
        user.imageUrl = res['results'][0]['picture']['medium'];
        userProvider.searchedUsers.add(user);
        res = await NetworkManager.instance
            .getRequest("https://randomuser.me/api/", 'token');
        user = UserModel(
            res['results'][0]['name']['first'],
            res['results'][0]['email'],
            res['results'][0]['location']['state'],
            res['results'][0]['location']['city'],
            res['results'][0]['picture']['medium'],
            "3");
        user.imageUrl = res['results'][0]['picture']['medium'];
        userProvider.searchedUsers.add(user);
        res = await NetworkManager.instance
            .getRequest("https://randomuser.me/api/", 'token');
        user = UserModel(
            res['results'][0]['name']['first'],
            res['results'][0]['email'],
            res['results'][0]['location']['state'],
            res['results'][0]['location']['city'],
            res['results'][0]['picture']['medium'],
            "3");
        user.imageUrl = res['results'][0]['picture']['medium'];
        userProvider.searchedUsers.add(user);
        res = await NetworkManager.instance
            .getRequest("https://randomuser.me/api/", 'token');
        user = UserModel(
            res['results'][0]['name']['first'],
            res['results'][0]['email'],
            res['results'][0]['location']['state'],
            res['results'][0]['location']['city'],
            res['results'][0]['picture']['medium'],
            "3");
        user.imageUrl = res['results'][0]['picture']['medium'];
        userProvider.searchedUsers.add(user);
        res = await NetworkManager.instance
            .getRequest("https://randomuser.me/api/", 'token');
        user = UserModel(
            res['results'][0]['name']['first'],
            res['results'][0]['email'],
            res['results'][0]['location']['state'],
            res['results'][0]['location']['city'],
            res['results'][0]['picture']['medium'],
            "3");
        user.imageUrl = res['results'][0]['picture']['medium'];
        userProvider.searchedUsers.add(user);
        res = await NetworkManager.instance
            .getRequest("https://randomuser.me/api/", 'token');
        user = UserModel(
            res['results'][0]['name']['first'],
            res['results'][0]['email'],
            res['results'][0]['location']['state'],
            res['results'][0]['location']['city'],
            res['results'][0]['picture']['medium'],
            "3");
        user.imageUrl = res['results'][0]['picture']['medium'];
        userProvider.searchedUsers.add(user);
        res = await NetworkManager.instance
            .getRequest("https://randomuser.me/api/", 'token');
        user = UserModel(
            res['results'][0]['name']['first'],
            res['results'][0]['email'],
            res['results'][0]['location']['state'],
            res['results'][0]['location']['city'],
            res['results'][0]['picture']['medium'],
            "3");
        user.imageUrl = res['results'][0]['picture']['medium'];
        userProvider.searchedUsers.add(user);
        userProvider.searchedUsers = userProvider.searchedUsers
            .where((element) =>
                element.userName.toLowerCase().contains(searchText))
            .toList();
      },
      context,
    );
    if (Utils.instance.errorDialogHelper(friendProvider, context) &&
        Utils.instance.errorDialogHelper(userProvider, context)) {
      setState(() {
        hasSearched = true;
      });
    }
  }
}
