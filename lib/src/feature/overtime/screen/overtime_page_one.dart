import 'package:flutter/material.dart';

import 'all_overtime.dart';
import 'my_overtime.dart';

class OvertimePageOne extends StatelessWidget {
  final String mydate;
  const OvertimePageOne({this.mydate = "This week"});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            brightness: Brightness.light,
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            title: Text(
              'Manage Overtime',
              style: TextStyle(color: Colors.white),
            ),
            bottom: TabBar(
              indicatorColor: Colors.grey,
              indicatorWeight: 2,
              tabs: [
                Tab(
                  child: Text("All Overtime",
                      style: TextStyle(color: Colors.white)),
                ),
                Tab(
                  child: Text("My Overtime",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            titleSpacing: 20,
          ),
          body: TabBarView(
            children: [
              Allovertime(),
              // Container(
              //   child: Text("all overtime"),
              // ),
              MyOvertime()
            ],
          ),
        ));
  }
}
