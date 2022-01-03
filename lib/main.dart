import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:qaf/utils_and_services/app_translations/app_translations.dart';
import 'package:qaf/utils_and_services/routing/navigation_service.dart';
import 'package:qaf/utils_and_services/routing/routes.dart';
import 'utils_and_services/routing/router.dart' as router;

import 'data/local_repository.dart';
import 'di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  runApp(const QafApp());
}

class QafApp extends StatefulWidget {
  const QafApp({Key? key}) : super(key: key);

  @override
  State<QafApp> createState() => _QafAppState();
}

class _QafAppState extends State<QafApp> {
  late AppTranslationsDelegate _appTranslationsDelegate;

  @override
  void initState() {
    super.initState();
    initLocale();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qaf',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        _appTranslationsDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        // Locale('en'),
        Locale('ar'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      builder: (_, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      navigatorKey: sl<NavigationService>().navigatorKey,
      initialRoute: preAppScreen,
      onGenerateRoute: router.Router.generateRoute,
    );
  }

  void initLocale() {
    String? lang = sl<LocalRepo>().getLanguage();
    _appTranslationsDelegate = AppTranslationsDelegate(
      locale: lang == null ? null : Locale(lang, ''),
    );
    application.onLocaleChanged = onLocaleChange;
  }

  void onLocaleChange(Locale locale) {
    sl<Dio>().options.headers.addAll({'lang': locale.languageCode});
    setState(() {
      _appTranslationsDelegate = AppTranslationsDelegate(locale: locale);
    });
  }
}
