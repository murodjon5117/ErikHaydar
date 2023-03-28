import 'dart:io';
import 'dart:ui';
import 'package:erik_haydar/firebase_options.dart';
import 'package:erik_haydar/provider/category_provider.dart';
import 'package:erik_haydar/provider/detail_film_provider.dart';
import 'package:erik_haydar/provider/detail_music_provider.dart';
import 'package:erik_haydar/provider/favorite_provider.dart';
import 'package:erik_haydar/provider/home_provider.dart';
import 'package:erik_haydar/provider/localization_provider.dart';
import 'package:erik_haydar/provider/login_provider.dart';
import 'package:erik_haydar/provider/profile_provider.dart';
import 'package:erik_haydar/provider/register_provider.dart';
import 'package:erik_haydar/provider/search_provider.dart';
import 'package:erik_haydar/provider/serial_provider.dart';
import 'package:erik_haydar/provider/user_data_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:erik_haydar/theme/light_theme.dart';
import 'package:erik_haydar/util/app_constants.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:provider/provider.dart';
import 'di_container.dart' as di;
import 'localization/app_localization.dart';
import 'view/sceen/splash/splash.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  // await FlutterDownloader.initialize();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  await di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<RegisterProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LoginProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<HomeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CategoryProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<FavoriteProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SearchProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SerialProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<FilmDetailProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<UserDataProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<MusicDetailProvider>()),
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
  void initState() {
    Provider.of<RegisterProvider>(context, listen: false).getFirebaseToken();
    super.initState();
  }

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
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      print('ishladiiiiii');
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    });

    return MaterialApp(
      home: const SplashScreen(),
      title: 'Yengil',
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
