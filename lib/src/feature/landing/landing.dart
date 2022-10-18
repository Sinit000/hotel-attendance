// import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:developer';

// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/src/config/routes/routes.dart';
import 'package:e_learning/src/feature/auth/bloc/index.dart';

import 'package:e_learning/src/feature/home/screen/home_page.dart';
import 'package:e_learning/src/feature/login_register/screens/login_register_page.dart';
import 'package:e_learning/src/feature/notification/res/notification_api.dart';
import 'package:e_learning/src/feature/notification/screen/widget/navigator.dart';
import 'package:e_learning/src/utils/service/api_provider.dart';
import 'package:e_learning/src/utils/share/helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lottie/lottie.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int notificationId = 1;
  AndroidNotificationChannel channel = AndroidNotificationChannel(
      "high_importance_channel",
      "High Importance Notifications",
      "High Importance Notifications",
      importance: Importance.high,
      playSound: true);
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print(message.data.toString());
    print("msg1");
    // Navigator.pushNamed(context, notification);

    notificationNavigator(context,
        target: message.data["target"].toString(),
        targetValue: message.data["target_value"].toString());
    print("Handling a background message");
  }

  ApiProvider _apiProvider = ApiProvider();

  initNotification(String authToken) async {
    Firebase.initializeApp().then((value) {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      messaging.requestPermission();
      messaging.subscribeToTopic("all").then((value) {
        messaging
            .setForegroundNotificationPresentationOptions(
                alert: true, badge: true, sound: true)
            .then((value) {
          String? token;
          // for push local notification

          messaging.getToken().then((value) {
            token = value;
            _updateFcm(authToken, token.toString());
            print("firebase divice : " + token.toString());
            FirebaseMessaging.instance.getInitialMessage().then((message) {
              print("FirebaseMessaging.getInitialMessage");
              if (message != null) {}
            });
            final FlutterLocalNotificationsPlugin
                flutterLocalNotificationsPlugin =
                FlutterLocalNotificationsPlugin();

            var initialzationSettingsAndroid =
                AndroidInitializationSettings('@mipmap/launcher_icon');
            var initializationSettings =
                InitializationSettings(android: initialzationSettingsAndroid);
            flutterLocalNotificationsPlugin.initialize(initializationSettings);

            FirebaseMessaging.onBackgroundMessage(
                firebaseMessagingBackgroundHandler);
            FirebaseMessaging.onMessage.listen((RemoteMessage message) {
              try {
                print("hi");
                notificationId = notificationId++;
                print("${message.notification!.title}");
                print(notificationId);
                print("${message.notification!.body}");
                log("open app");
                RemoteNotification? notification = message.notification!;
                AndroidNotification? android = message.notification!.android!;
                if (notification != null && android != null) {
                  print("on meesage openapp");
                  NotificationApi.showNotification(
                      title: notification.title!,
                      body: notification.title!,
                      payload: 'attendance');
                  flutterLocalNotificationsPlugin.show(
                      notification.hashCode,
                      notification.title,
                      notification.title,
                      NotificationDetails(
                        android: AndroidNotificationDetails(
                            channel.id, channel.name, channel.description,
                            icon: '@mipmap/launcher_icon'),
                      ));

                  print("work or not");
                  FirebaseMessaging.onMessageOpenedApp
                      .listen(firebaseMessagingBackgroundHandler);
                }
              } catch (e) {}
            });
          });
        });
      });
    });
  }

  @override
  void initState() {
    // initNotification("");

    super.initState();
    // Timer(
    //     Duration(seconds: 3),
    //     () => Navigator.pushAndRemoveUntil(context,
    //             MaterialPageRoute(builder: (context) {
    //           return BlocBuilder<AuthenticationBloc, AuthenticationState>(
    //               builder: (context, state) {
    //             if (state is Authenticated) {
    //               return Home();
    //             }
    //             if (state is NotAuthenticated) {
    //               return LoginRegisterPage();
    //             } else {
    //               return Scaffold(
    //                 body: Center(
    //                   child: CircularProgressIndicator(),
    //                 ),
    //               );
    //             }
    //             // return Home();
    //           });
    //         }), (route) => false));
  }

  _updateFcm(String? authToken, String? deviceToken) async {
    // var headers = {
    //   'Authorization': 'Bearer $authToken',
    //   'Content-Type': 'application/json'
    // };
    // var request = http.Request(
    //     'POST',
    //     Uri.parse(
    //         'https://system.anakutapp.com/anakut_multi/public/api/update/fcm'));
    // request.body = '''{\r\n   "device_token":"$token"\r\n}''';
    // request.headers.addAll(headers);
    String url = "${dotenv.env['baseUrl']}notification/update/fcm";
    // http.StreamedResponse response = await request.send();
    Map body = {
      // "type": "company",
      "device_token": deviceToken,
    };
    print("device toke $deviceToken");

    Response response = await _apiProvider.post(url, body, null);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      print("send device token success");
    } else {
      print("error device token");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is Authenticated) {
        return HomePage();
      }
      if (state is ErrorAuthentication) {
        Helper.handleState(state: state, context: context);
      }
      if (state is NotAuthenticated) {
        return LoginRegisterPage(isLogin: true);
      }
      return Scaffold(
        body: Center(
          // child: CircularProgressIndicator(),
          child: Lottie.asset('assets/animation/loader.json',
              width: 200, height: 200),
        ),
      );
    }, listener: (context, state) {
      if (state is Authenticated) {
        initNotification(state.userModel.token!);
      }
    });
  }
}

// Future<void> onMessageOpenedApp(RemoteMessage message) async {
//   try {
//     notificationNavigator(context,
//         target: message.data["target"].toString(),
//         targetValue: message.data["target_value"].toString());
//   } catch (e) {
//     log(e.toString());
//   }
// }
