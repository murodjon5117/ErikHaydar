import 'dart:io';
import 'dart:ui';
import 'package:erik_haydar/provider/localization_provider.dart';
import 'package:erik_haydar/provider/login_provider.dart';
import 'package:erik_haydar/provider/profile_provider.dart';
import 'package:erik_haydar/provider/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:erik_haydar/theme/light_theme.dart';
import 'package:erik_haydar/util/app_constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'di_container.dart' as di;
import 'localization/app_localization.dart';
import 'view/sceen/splash/splash.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<RegisterProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LoginProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(ColorResources.COLOR_WHITE);
    List<Locale> locals = [];
    for (var language in AppConstants.languages) {
      locals.add(
        Locale.fromSubtags(
          languageCode: language.languageCode!,
          scriptCode: language.scriptsCode,
          countryCode: language.countryCode,
        ),
      );
    }
    return MaterialApp(
      home: SplashScreen(),
      title: 'Erik',
      debugShowCheckedModeBanner: false,
      navigatorKey: MyApp.navigatorKey,
      theme: light,
      darkTheme: light,
      locale: Provider.of<LocalizationProvider>(context).locale,
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: locals,
      scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown
      }),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
