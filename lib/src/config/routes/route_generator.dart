import 'package:e_learning/src/feature/account/screen/account_page_one.dart';
import 'package:e_learning/src/feature/changeDayof/screen/add_change_dayoff.dart';
import 'package:e_learning/src/feature/changeDayof/screen/change_dayoff_page.dart';
import 'package:e_learning/src/feature/changeDayof/screen/my_dayoff.dart';
import 'package:e_learning/src/feature/checkin/screen/attendance.dart';
import 'package:e_learning/src/feature/employee/screen/team_profile.dart';
import 'package:e_learning/src/feature/leaveout/screen/add_leaveout.dart';
import 'package:e_learning/src/feature/leaveout/screen/all_leaveout_page_chief.dart';
import 'package:e_learning/src/feature/leaveout/screen/all_leaveout_security.dart';
import 'package:e_learning/src/feature/leaveout/screen/my_leaveout_page.dart';
import 'package:e_learning/src/feature/notification/screen/notification_page.dart';
import 'package:e_learning/src/feature/ot_compesation/screen/ot_comesation_page.dart';
import 'package:e_learning/src/feature/overtime/model/overtime_model.dart';
import 'package:e_learning/src/feature/overtime/screen/add_overtime.dart';
import 'package:e_learning/src/feature/overtime/screen/all_overtime.dart';
import 'package:e_learning/src/feature/overtime/screen/edit_overtime.dart';
import 'package:e_learning/src/feature/overtime/screen/my_overtime.dart';
import 'package:e_learning/src/feature/overtime/screen/overtime_page.dart';
import 'package:e_learning/src/feature/payslip/screen/payslip_page.dart';

import 'package:e_learning/src/feature/permission/screen/add_leave.dart';
import 'package:e_learning/src/feature/permission/screen/all_leave.dart';
import 'package:e_learning/src/feature/permission/screen/leave_page.dart';
import 'package:e_learning/src/feature/permission/screen/my_leave.dart';
import 'package:e_learning/src/feature/report/screen/report_page.dart';
import 'package:flutter/material.dart';

import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case attendance:
        return MaterialPageRoute(builder: (_) => Attendance());
      // case saleReport:
      //   return MaterialPageRoute(builder: (_) => SaleReportPage());
      case account:
        return MaterialPageRoute(builder: (_) => AccountPage());

      case leave:
        return MaterialPageRoute(builder: (_) => LeavePage());
      case report:
        return MaterialPageRoute(builder: (_) => ReportPage());
      case addLeave:
        return MaterialPageRoute(builder: (_) => AddLeave());
      case myleave:
        return MaterialPageRoute(builder: (_) => MyLeave());
      case allleave:
        return MaterialPageRoute(builder: (_) => AllLeave());
      case myleaveout:
        return MaterialPageRoute(builder: (_) => MyLeaveoutPage());
      case addLeaveout:
        return MaterialPageRoute(builder: (_) => AddLeaveout());
      case allLeaveoutC:
        return MaterialPageRoute(builder: (_) => AllLeaveoutCheif());
      case allLeaveoutS:
        return MaterialPageRoute(builder: (_) => AllLeaveoutSecurity());
      case payslip:
        return MaterialPageRoute(builder: (_) => PayslipPage());
      case overtime:
        return MaterialPageRoute(builder: (_) => OvertimePage());
      case allovertime:
        return MaterialPageRoute(builder: (_) => Allovertime());
      case myovertime:
        return MaterialPageRoute(builder: (_) => MyOvertime());
      case otcompesation:
        return MaterialPageRoute(builder: (_) => OTCompesation());
      case addovertime:
        return MaterialPageRoute(builder: (_) => AddOvertime());
      case editovertime:
        if (args is OvertimeModel) {
          return MaterialPageRoute(
              builder: (_) => EditOvertime(
                    overtimeModel: args,
                  ));
        }
        return _errorRoute();
      case teamProfile:
        return MaterialPageRoute(builder: (_) => TeamProfile());
      case dayoff:
        return MaterialPageRoute(builder: (_) => ChangeDayOffPage());
      case addDayoff:
        return MaterialPageRoute(builder: (_) => AddChangeDayoff());
      case mydayOff:
        return MaterialPageRoute(builder: (_) => MyDayOff());
      case notification:
        return MaterialPageRoute(builder: (_) => NotificationPage());
      // case editCustomer:
      //   if (args is Customer) {
      //     return MaterialPageRoute(
      //         builder: (_) => EditCustomerPage(
      //               customer: args,
      //             ));
      //   }
      //   return _errorRoute();
      // case editCategory:
      //   if (args is Category) {
      //     return MaterialPageRoute(
      //         builder: (_) => EditCategoryPage(
      //               category: args,
      //             ));
      //   }
      //   return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
