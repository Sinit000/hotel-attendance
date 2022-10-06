import 'dart:developer';

import 'package:e_learning/src/config/routes/routes.dart';
import 'package:e_learning/src/feature/changeDayof/screen/my_dayoff.dart';
import 'package:e_learning/src/feature/leaveout/screen/my_leaveout_page.dart';
import 'package:e_learning/src/feature/ot_compesation/screen/ot_comesation_page.dart';
import 'package:e_learning/src/feature/overtime/screen/my_overtime.dart';
import 'package:e_learning/src/feature/permission/screen/my_leave.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

notificationNavigator(BuildContext context,
    {required String? target, required String? targetValue}) {
  log("$target $targetValue");
  if (target != null) {
    switch (target) {
      case "inform_notification":
        Navigator.pushNamed(context, notification);
        break;
      case "inform_leave":
        Navigator.push(context, MaterialPageRoute(builder: (con) => MyLeave()));
        break;
      case "inform_overtime":
        Navigator.push(
            context, MaterialPageRoute(builder: (con) => MyOvertime()));
        break;
      case "inform_dayoff":
        Navigator.push(
            context, MaterialPageRoute(builder: (con) => MyDayOff()));
        break;
      case "inform_otcompesation":
        Navigator.push(
            context, MaterialPageRoute(builder: (con) => OTCompesation()));
        break;
      case "inform_leaveout":
        Navigator.push(
            context, MaterialPageRoute(builder: (con) => MyLeaveoutPage()));
        break;
      default:
        break;
    }
  }
}
