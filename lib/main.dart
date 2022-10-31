// import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:io';

import 'package:e_learning/src/config/routes/route_generator.dart';
import 'package:e_learning/src/feature/account/bloc/index.dart';
import 'package:e_learning/src/feature/auth/bloc/index.dart';
import 'package:e_learning/src/feature/changeDayof/bloc/changedayoff_bloc.dart';
import 'package:e_learning/src/feature/checkin/bloc/index.dart';
import 'package:e_learning/src/feature/language/bloc/index.dart';
import 'package:e_learning/src/feature/notification/bloc/index.dart';
import 'package:e_learning/src/feature/ot_compesation/bloc/index.dart';
import 'package:e_learning/src/feature/permission/bloc/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'appLocalizations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'src/feature/home/check_connectivity.dart';
import 'src/feature/home/screen/widget/mylocation.dart';
import 'src/feature/landing/landing.dart';
import 'src/feature/leaveout/bloc/index.dart';
import 'src/feature/notification/res/notification_api.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'src/feature/notification/screen/local_notification.dart';

///Receive message when app is in background solution for on message
// GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
// AndroidNotificationChannel channel = AndroidNotificationChannel(
//     "high_importance_channel",
//     "High Importance Notifications",
//     "High Importance Notifications",
//     importance: Importance.high,
//     playSound: true);
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('A bg message just showed up :  ${message.messageId}');
// }

enum Env { Production, Developement }
final Env env = Env.Production;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: getServerEnvAssetPath(env));
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  // // AwesomeNotifications().initialize(
  //     "resource://drawable/ic_stat_ic_launcher",
  //     [
  //       NotificationChannel(
  //           channelKey: "local", channelDescription: '', channelName: 'local')
  //     ],
  //     debug: true);

  // tz.initializeTimeZones();
  // var locations = tz.timeZoneDatabase.locations;
  // print(locations.length); // => 429
  // print(locations.keys.first); // => "Africa/Abidjan"
  // print(locations.keys.last); //
  // NotificationApi.showNotification(
  //   title: "Hi sinit",
  //   body: "Dinner at 4:30 pm",
  //   payload: "sinit",
  // );
  // await Firebase.initializeApp();
  // // await Firebase.
  // SystemChrome.setEnabledSystemUIMode();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  //   // change status bar color
  // ));

  // await LocalNotificationService().initialize();
  // runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(MyApp());
  });
}

String getServerEnvAssetPath(Env env) {
  late final String path;
  switch (env) {
    case Env.Developement:
      path = '';
      break;
    case Env.Production:
      path = 'assets/.env';
      break;
  }
  return path;
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // auth need initalize event because need to check auth for open the app
        BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) =>
                AuthenticationBloc()..add(CheckingAuthenticationStarted())),
        BlocProvider<LeaveBloc>(create: (BuildContext context) => LeaveBloc()),
        BlocProvider<LanguageBloc>(
            create: (BuildContext context) =>
                LanguageBloc()..add(LanguageLoadStarted())),
        BlocProvider<LeaveOutBloc>(
            create: (BuildContext context) => LeaveOutBloc()),
        BlocProvider<ChangeDayOffBloc>(
            create: (BuildContext context) => ChangeDayOffBloc()),
        BlocProvider<AccountBloc>(
            create: (BuildContext context) => AccountBloc()),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            locale: state.locale,
            onGenerateRoute: RouteGenerator.generateRoute,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              AppLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en', 'US'),
              Locale('km', 'KH'),
              // Locale('zh', 'CN'),
            ],
            debugShowCheckedModeBanner: false,
            title: 'Attendance App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: LandingPage(),
            builder: EasyLoading.init(),
          );
        },
      ),
    );
  }
}
