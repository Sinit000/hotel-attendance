import 'package:e_learning/src/feature/ot_compesation/screen/ot_comesation_page.dart';
import 'package:e_learning/src/feature/ot_compesation/screen/song_mong_page.dart';
import 'package:flutter/material.dart';

class OTCompensationDashBoard extends StatelessWidget {
  const OTCompensationDashBoard({Key? key}) : super(key: key);

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
            'OVertime Compensation',
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            indicatorColor: Colors.grey,
            indicatorWeight: 2,
            tabs: [
              Tab(
                child: Text("Clear Overtime ",
                    style: TextStyle(color: Colors.white)),
              ),
              Tab(
                child: Text("Song Mong", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          titleSpacing: 20,
        ),
        body: TabBarView(
          children: [
            OTCompesation(),
            SongMongPage()
            // ReportPage(),
            // CheckinReport(),
          ],
        ),
      ),
    );
  }
}
