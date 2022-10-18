import 'package:e_learning/src/feature/holiday/bloc/holiday_bloc.dart';
import 'package:e_learning/src/feature/holiday/bloc/holiday_event.dart';
import 'package:e_learning/src/feature/holiday/bloc/holiday_state.dart';
import 'package:e_learning/src/feature/holiday/model/holiday_model.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../appLocalizations.dart';

class HolidayPage extends StatefulWidget {
  const HolidayPage({Key? key}) : super(key: key);

  @override
  State<HolidayPage> createState() => _HolidayPageState();
}

class _HolidayPageState extends State<HolidayPage> {
  HolidayBloc _holidayBloc = HolidayBloc();
  final RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    _holidayBloc.add(InitailizePHStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(
          context, "${AppLocalizations.of(context)!.translate("holiday")!}"),
      body: Container(
        margin: EdgeInsets.all(8),
        child: BlocConsumer(
            bloc: _holidayBloc,
            builder: (context, state) {
              if (state is InitailizingPH) {
                return Center(
                  child: Lottie.asset('assets/animation/loader.json',
                      width: 200, height: 200),
                );
              }
              if (state is ErrorFetchingHoliday) {
                return Center(
                  child: TextButton(
                      onPressed: () {
                        _holidayBloc.add(InitailizePHStarted());
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.teal,
                        onSurface: Colors.grey,
                      ),
                      child: Text("Retry")),
                );
              } else {
                if (_holidayBloc.holidaylist.length == 0) {
                  return Center(
                    child: Text("No Data"),
                  );
                }
                return ListView.builder(
                    itemCount: _holidayBloc.holidaylist.length,
                    itemBuilder: (context, index) {
                      return _buildCard(
                          holidayModel: _holidayBloc.holidaylist[index]);
                    });
              }
            },
            listener: (context, state) {
              print("state");
              print(state);
              // if (state is FetchedNotification) {
              //   _refreshController.loadComplete();
              //   _refreshController.refreshCompleted();
              // }
              // if (state is EndOfNotificationList) {
              //   _refreshController.loadNoData();
              // }
            }),
      ),
    );
  }

  _buildCard({required HolidayModel holidayModel}) {
    return Card(
      child: Container(
        // margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          border: Border.all(
            color: holidayModel.status == "pending" ? Colors.green : Colors.red,
            // width: 5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.date_range,
                    size: 18.0,
                    color: Colors.orange[900],
                  ),
                  Text(
                    " " +
                        '${holidayModel.fromDate}' +
                        "/" +
                        '${holidayModel.toDate}',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  // Icon(
                  //   Icons.date_range,
                  //   size: 18.0,
                  //   color: Colors.orange[900],
                  // ),
                  Expanded(
                    child: Text(
                      " " + holidayModel.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              // SizedBox(
              //   height: 5.0,
              // ),
              // Row(
              //   children: [
              //     Text(
              //       " " + holidayModel.status!,
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _holidayBloc.close();
    super.dispose();
  }
}
