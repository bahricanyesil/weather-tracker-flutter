import 'package:flutter/material.dart';

import '../../core_shelf.dart';

class UserListItem extends StatelessWidget {
  final UserModel user;
  const UserListItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final friendProv = Provider.of<FriendProvider>(context, listen: false);
    final receivedRequestIndex = friendProv.receivedRequests
        .indexWhere((e) => e.uniqueId == user.uniqueId);
    final sentRequestIndex =
        friendProv.sentRequests.indexWhere((e) => e.uniqueId == user.uniqueId);
    final friendIndex =
        friendProv.friendsOfUser.indexWhere((e) => e.uniqueId == user.uniqueId);
    return ListTile(
      leading: getLeading(context),
      title: AutoSizeText(user.userName),
      subtitle: AutoSizeText('${user.city}, ${user.country}'),
      trailing: FittedBox(
        fit: BoxFit.contain,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            getLeftButton(context, receivedRequestIndex),
            SizedBox(width: context.width * 3),
            getRightButton(
                context, receivedRequestIndex, sentRequestIndex, friendIndex),
            SizedBox(width: context.width * 0.8),
          ],
        ),
      ),
    );
  }

  Widget getLeftButton(BuildContext context, int receivedIndex) =>
      receivedIndex != -1
          ? getIconButton(() => reject(context), Icons.cancel_outlined,
              ColorConstants.rejectRed, context)
          : Container();

  Widget getRightButton(
      BuildContext context, int receivedIndex, int sentIndex, int friendIndex) {
    if (receivedIndex != -1) {
      return getIconButton(() => accept(context), Icons.done,
          ColorConstants.acceptGreen, context);
    } else if (sentIndex != -1) {
      return getIconButton(
          () {}, Icons.hourglass_bottom_outlined, Colors.yellowAccent, context);
    } else if (friendIndex != -1) {
      return getIconButton(() {}, Icons.group_outlined, Colors.green, context);
    } else {
      return getIconButton(() => sendRequest(context),
          Icons.person_add_outlined, context.accentColor, context);
    }
  }

  Widget getIconButton(Function() onPressed, IconData icon, Color iconColor,
      BuildContext context) {
    return IconButton(
      splashColor: context.accentColor,
      splashRadius: context.width * 5,
      onPressed: onPressed,
      icon: Icon(icon, color: iconColor),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }

  Widget getLeading(BuildContext context) {
    return SizedBox(
      width: context.width * 15,
      child: ClipRRect(
        borderRadius: context.highCircular,
        child: FadeInImage.assetNetwork(
          image: user.imageUrl,
          placeholder: 'assets/images/loading.gif',
          alignment: Alignment.center,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Future<void> reject(BuildContext context) async {
    final friendProvider = Provider.of<FriendProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await ServiceUtils.instance.requestHelper(
      () => friendProvider.rejectRequest(
          user.uniqueId, userProvider.user.uniqueId),
      context,
    );
    if (Utils.instance.errorDialogHelper(friendProvider, context)) {}
  }

  Future<void> accept(BuildContext context) async {
    final friendProvider = Provider.of<FriendProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await ServiceUtils.instance.requestHelper(
      () => friendProvider.acceptRequest(
          user.uniqueId, userProvider.user.uniqueId),
      context,
    );
    if (Utils.instance.errorDialogHelper(friendProvider, context)) {}
  }

  Future<void> sendRequest(BuildContext context) async {
    final friendProvider = Provider.of<FriendProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await ServiceUtils.instance.requestHelper(
      () => friendProvider.createFriend(userProvider.user.uniqueId, user),
      context,
    );
    if (Utils.instance.errorDialogHelper(friendProvider, context)) {}
  }
}
