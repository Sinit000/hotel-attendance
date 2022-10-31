import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_learning/src/config/routes/routes.dart';
import 'package:e_learning/src/feature/account/bloc/index.dart';
import 'package:e_learning/src/feature/auth/bloc/authentication_bloc.dart';
import 'package:e_learning/src/feature/auth/bloc/authentication_state.dart';
import 'package:e_learning/src/feature/home/check_connectivity.dart';
import 'package:e_learning/src/feature/home/screen/menu.dart';
import 'package:e_learning/src/feature/home/screen/widget/home_item.dart';
import 'package:e_learning/src/feature/notification/res/notification_api.dart';
import 'package:e_learning/src/feature/notification/screen/local_notification.dart';
import 'package:e_learning/src/feature/notification/screen/notification_page.dart';
import 'package:e_learning/src/feature/timetable/model/schedule_model.dart';
import 'package:e_learning/src/feature/timetable/model/timetable_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../../appLocalizations.dart';
import 'home_menu.dart';
import 'my_app_bar.dart';
import 'package:flutter/foundation.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Map _source = {ConnectivityResult.none: false};
  // final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  String string = '';
  // ConnectivityService connectivityService = ConnectivityService();
  @override
  void initState() {
    super.initState();
    // connectivityService.checkInternetConnection();
    // _networkConnectivity.initialise();
    // _networkConnectivity.myStream.listen((source) {
    //   _source = source;
    //   print('source $_source');
    //   // 1.
    //   switch (_source.keys.toList()[0]) {
    //     case ConnectivityResult.mobile:
    //       string =
    //           _source.values.toList()[0] ? 'Mobile: Online' : 'Mobile: Offline';
    //       break;
    //     case ConnectivityResult.wifi:
    //       string =
    //           _source.values.toList()[0] ? 'WiFi: Online' : 'WiFi: Offline';
    //       break;
    //     case ConnectivityResult.none:
    //     default:
    //       string = 'Offline';
    //   }
    //   // 2.
    //   setState(() {});
    //   // 3.
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(
    //         string,
    //         style: TextStyle(fontSize: 30),
    //       ),
    //     ),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map> homeMenuUser = [
      {
        "name": "${AppLocalizations.of(context)!.translate("attendance")!}",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/checking-attendance.png",
        "onPressed": () {
          Navigator.pushNamed(context, attendance);
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("account")!}",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/user.png",
        "onPressed": () {
          Navigator.pushNamed(context, account);
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("leave")!}",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/file.png",
        "onPressed": () {
          Navigator.pushNamed(context, leave);
          // BlocProvider.of<AuthenticationBloc>(context).state.user!.isManager !=
          //         "true"
          //     ? Navigator.pushNamed(context, myleave)
          //     :
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("ot")!}",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/overtime.png",
        "onPressed": () {
          Navigator.pushNamed(context, overtime);
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("payslip")!}",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/money.png",
        "onPressed": () {
          Navigator.pushNamed(context, payslip);
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("changing")!}",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/calendar.png",
        "onPressed": () {
          Navigator.pushNamed(context, mydayOff);
          // BlocProvider.of<AuthenticationBloc>(context).state.user!.roleName ==
          //         "Cheif Department"
          //     ? Navigator.pushNamed(context, dayoff)
          //     : Navigator.pushNamed(context, mydayOff);
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("team_profile")!}",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/group.png",
        "onPressed": () {
          Navigator.pushNamed(context, teamProfile);
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("report")!}",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/analytics.png",
        "onPressed": () {
          Navigator.pushNamed(context, dashReport);
        }
      },
    ];

    print(BlocProvider.of<AuthenticationBloc>(context).state.user!.roleName);
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 100), child: MyAppBar()),
      body: ListView(
        clipBehavior: Clip.none,
        children: [
          Stack(
            children: [
              Container(
                height:
                    15 + ((MediaQuery.of(context).size.width / 2) - (45)) / 2.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      bottom: new Radius.elliptical(
                          MediaQuery.of(context).size.width, 60.0)),
                  color: Theme.of(context).primaryColor,
                ),
              ),
              OrientationBuilder(builder: (context, orie) {
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  // child: GridView.count(crossAxisCount: 2,children: [

                  // ],),
                  child: GridView.builder(
                    padding: EdgeInsets.only(
                        top: 0, right: 15, bottom: 15, left: 15),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 4 / 2.5,
                        crossAxisCount: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 2
                            : 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15),
                    itemBuilder: (_, index) {
                      return homeItem(
                          iconColor: homeMenuUser[index]["iconColor"],
                          name: homeMenuUser[index]["name"],
                          image: homeMenuUser[index]["image"],
                          onPressed: homeMenuUser[index]["onPressed"]);
                    },
                    itemCount: homeMenuUser.length,
                  ),
                );
              })
            ],
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     // await flutterLocalNotificationsPlugin.show(
      //     //     0,
      //     //     'plain title',
      //     //     'plain body',
      //     //     NotificationDetails(
      //     //       android: AndroidNotificationDetails(
      //     //           '', '', 'channel.description',
      //     //           icon: '@mipmap/launcher_icon'),
      //     //     ),
      //     //     payload: 'item x');
      //     _showNotificationWithActions();
      //   },
      //   child: Icon(Icons.play_arrow),
      // ),
    );
  }

  // Future<void> _showNotificationWithActions() async {
  //   print('object');
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //     '...',
  //     '...',
  //     '...',
  //   );
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       0, '...', '...', notificationDetails);
  // }
  // @override
  // void dispose() {
  //   _networkConnectivity.disposeStream();
  //   super.dispose();
  // }
}
