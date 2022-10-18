import 'package:e_learning/src/feature/report/bloc/index.dart';
import 'package:e_learning/src/feature/report/bloc/report_bloc.dart';
import 'package:e_learning/src/feature/report/screen/report_page.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'checkin_report.dart';

class ReportWithDashboard extends StatelessWidget {
  const ReportWithDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          // backgroundColor: HexColor("#ff4e00"),
          centerTitle: true,
          title: Text(
            'Report',
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            indicatorColor: Colors.grey,
            indicatorWeight: 2,
            tabs: [
              Tab(
                child: Text("Summary ", style: TextStyle(color: Colors.white)),
              ),
              Tab(
                child:
                    Text("Attendance", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          titleSpacing: 20,
        ),
        body: TabBarView(
          children: [
            ReportPage(),
            CheckinReport(),
          ],
        ),
      ),
    );
  }
}
