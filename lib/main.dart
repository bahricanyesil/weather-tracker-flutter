import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/core_shelf.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalManager.prefrencesInit();
  var languageProvider = LanguageProvider();
  await languageProvider.fetchLocale();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    MultiProvider(
      providers: [...?ApplicationProvider.instance?.dependItems],
      child: MyApp(languageProvider: languageProvider),
    ),
  );
}

class MyApp extends StatefulWidget {
  final LanguageProvider languageProvider;
  const MyApp({Key? key, required this.languageProvider}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, modal, child) => MaterialApp(
        title: 'WeTrack',
        debugShowCheckedModeBanner: false,
        theme: getDarkTheme(),
        localizationsDelegates: [...AppLocalizations.localDelegates],
        locale: modal.appLocal == const Locale('no')
            ? widget.languageProvider.appLocal
            : modal.appLocal,
        initialRoute: '/home',
        supportedLocales: [...AppLocalizations.locales],
        onGenerateRoute: NavigationRoute.instance.generateRoute,
        navigatorKey: NavigationService.instance.navigatorKey,
      ),
    );
  }
}
