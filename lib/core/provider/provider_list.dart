import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core_shelf.dart';

class ApplicationProvider {
  static ApplicationProvider? _instance;
  static ApplicationProvider? get instance {
    _instance ??= ApplicationProvider._init();
    return _instance;
  }

  ApplicationProvider._init();

  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(create: (context) => LanguageProvider()),
    ChangeNotifierProvider(create: (context) => FriendProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => ParticipanceProvider()),
    ChangeNotifierProvider(create: (context) => MeetingProvider()),
    Provider.value(value: NavigationService.instance)
  ];
}
