import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../core/core_shelf.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  final List<TextEditingController> _controllers =
      List.generate(3, (index) => TextEditingController());
  final List<String> _textKeys = ['username', 'city', 'country'];

  void changeLanguage(context) async {
    var lang = Localizations.localeOf(context).languageCode;
    var appLanguage = Provider.of<LanguageProvider>(context, listen: false);
    await appLanguage.changeLanguage(lang == 'tr' ? 'en' : 'tr');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: context.height * 3),
        getList(context),
      ],
    );
  }

  Widget getList(BuildContext context) {
    return Expanded(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          profileIcon(context),
          updateUser(context),
          languageItem(context),
          changePassword(context),
          feedbackItem(context),
          contactItem(context),
          storeItem(context),
        ],
      ),
    );
  }

  Widget profileIcon(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: context.bottomMedium,
        padding: context.mediumEdgeInsets,
        decoration: BoxDecorations.instance.roundedDeco(context),
        child: Icon(Icons.person, size: context.width * 19),
      ),
    );
  }

  Widget updateUser(BuildContext context) {
    return SettingsItem(
      icon: Icons.info_outline,
      text: 'update_info'.translate,
      hasNavigation: false,
      function: () => _updateInfo(context),
    );
  }

  Widget changePassword(BuildContext context) {
    return SettingsItem(
      icon: Icons.lock_outline,
      text: 'change_password'.translate,
      hasNavigation: false,
      function: () => NavigationService.instance
          .navigateToPage(path: NavigationConstants.changePassword),
    );
  }

  Widget languageItem(BuildContext context) {
    final isTurkish = Localizations.localeOf(context).languageCode == 'tr';
    return SettingsItem(
      icon: Icons.language_outlined,
      text: isTurkish ? 'convert_to_en'.translate : 'convert_to_tr'.translate,
      hasNavigation: false,
      function: () => changeLanguage(context),
    );
  }

  Widget feedbackItem(BuildContext context) {
    return SettingsItem(
      icon: Icons.format_list_bulleted_outlined,
      text: 'give_feedback'.translate,
      hasNavigation: false,
      function: () => Utils.instance.urlHelper(
          Localizations.localeOf(context).languageCode == 'tr'
              ? 'https://forms.gle/6CrFRMigv38gnRPq5'
              : 'https://forms.gle/yMuthkT3LsJHzmMv9'),
    );
  }

  Widget contactItem(BuildContext context) {
    return SettingsItem(
      icon: Icons.email_outlined,
      text: 'contact_developer'.translate,
      hasNavigation: false,
      function: () {
        // ignore: omit_local_variable_types
        final Uri params = Uri(
            scheme: 'mailto',
            path: 'bahricanyesil@gmail.com',
            queryParameters: {'subject': 'WeTrack-App'});
        final url = params.toString();
        Utils.instance.urlHelper(url);
      },
    );
  }

  Widget storeItem(BuildContext context) {
    return SettingsItem(
      icon: Icons.star,
      text: 'rate_us'.translate,
      hasNavigation: false,
      function: () async {
        // ignore: omit_local_variable_types
        final InAppReview inAppReview = InAppReview.instance;
        await inAppReview.openStoreListing(
          appStoreId: '1559425754',
        );
      },
    );
  }

  void _updateInfo(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context, listen: false);
    _controllers[0].text = userProv.user.userName;
    _controllers[1].text = userProv.user.city;
    _controllers[2].text = userProv.user.country;
    CustomDialog(
      title: Text(
        'update_info'.translate,
        style: context.headline5,
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(
            3,
            (int index) => EditText(
                controller: _controllers[index], hintText: _textKeys[index])),
      ),
      action: () => saveInfo(context),
    ).show(context);
  }

  Future<void> saveInfo(BuildContext context) async {
    final userProv = Provider.of<UserProvider>(context, listen: false);
    await ServiceUtils.instance.requestHelper(
      () => userProv.updateUser(
        userProv.user.uniqueId,
        _controllers[0].text,
        _controllers[2].text,
        _controllers[1].text,
        userProv.user.notificationToken,
      ),
      context,
    );
    if (Utils.instance.errorDialogHelper(userProv, context)) {}
  }

  Text getText(String key, BuildContext context) =>
      Text(key.translate, style: textStyleDefault(context));

  TextStyle textStyleDefault(BuildContext context) {
    return TextStyle(color: context.primaryLightColor);
  }
}
