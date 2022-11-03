import 'package:e_learning/src/feature/report/bloc/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';

class CheckinReport extends StatefulWidget {
  const CheckinReport({Key? key}) : super(key: key);

  @override
  State<CheckinReport> createState() => _CheckinReportState();
}

class _CheckinReportState extends State<CheckinReport> {
  ReportBloc _reportBloc = ReportBloc();
  final RefreshController _refreshController = RefreshController();
  String mydateRange = "This month";
  @override
  void initState() {
    _reportBloc.add(
        InitailizeAttendanceStarted(dateRange: mydateRange, isSecond: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer(
          bloc: _reportBloc,
          builder: (context, state) {
            if (state is InitializingReport) {
              return Center(
                child: Lottie.asset('assets/animation/loader.json',
                    width: 200, height: 200),
              );
            }

            if (state is ErrorFetchingReport) {
              return Center(
                child: TextButton(
                    onPressed: () {
                      _reportBloc.add(InitailizeAttendanceStarted(
                          dateRange: mydateRange, isSecond: true));
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.teal,
                      onSurface: Colors.grey,
                    ),
                    child: Text("Retry")),
              );
            }
            return Column(children: [
              _reportBloc.dateRange == null
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: DropdownButton<String>(
                        hint: _reportBloc.dateRange!.contains("to")
                            ? Text("${_reportBloc.dateRange!}")
                            : Text(
                                // leaveBloc.dateRange!,
                                // _reportBloc.dateRange!.contains("to")
                                //     ? _reportBloc.dateRange!
                                //     :W
                                "${_reportBloc.dateRange!}",
                                textScaleFactor: 1,
                              ),
                        items: [
                          'Today',
                          'This week',
                          'This month',
                          'This year',
                          "Custom"
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value == "Custom") {
                            showPickerDateRange(context);
                            // _reportBloc
                            // .add(InitailizeReportStarted(dateRange: value));
                          } else {
                            setState(() {
                              mydateRange = value!;
                              print("myvalue $mydateRange");
                            });
                            _reportBloc.add(InitailizeAttendanceStarted(
                                dateRange: mydateRange, isSecond: true));
                          }
                        },
                      ),
                    ),
              Container(
                width: double.infinity,
                height: 10,
                color: Colors.transparent,
              ),
              _reportBloc.myreport.length == 0
                  ? Container(
                      child: Text("No data"),
                    )
                  : Expanded(
                      child: SmartRefresher(
                      onRefresh: () {
                        _reportBloc.add(InitailizeAttendanceStarted(
                            dateRange: mydateRange,
                            isSecond: true,
                            isRefresh: 'yes'));
                      },
                      onLoading: () {
                        _reportBloc.add(
                            FetchAttendanceStarted(dateRange: mydateRange));
                      },
                      enablePullDown: true,
                      enablePullUp: true,
                      controller: _refreshController,
                      child: ListView.builder(
                        cacheExtent: 1000,
                        // physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        // padding: EdgeInsets.only(left: 10, top: 10, right: 0),

                        itemCount: _reportBloc.myreport.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                bottom: 10.0, left: 8.0, right: 8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(6.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Text(
                                          "Date :",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Text(
                                        "${_reportBloc.myreport[index].date}",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Text(
                                          "Checkin Time :",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${_reportBloc.myreport[index].checkinTime} ",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // Text("- "),
                                          // Text(
                                          //   " ${BlocProvider.of<WantedBloc>(context).wantedList[index].maxPrice}",
                                          //   style: TextStyle(
                                          //       color: Colors.red,
                                          //       fontWeight: FontWeight.bold),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Text(
                                          "Checkin Status :",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Text(
                                        "${_reportBloc.myreport[index].checkitStatus} ${_reportBloc.myreport[index].checkinLate} mn",
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Text(
                                          "Checkout time :",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Text(
                                        "${_reportBloc.myreport[index].checkoutTime}",
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Text(
                                          "Checkout Status :",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Text(
                                        "${_reportBloc.myreport[index].checkoutStatus}  ${_reportBloc.myreport[index].checkoutLate}",
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Text(
                                          "Duration :",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Text(
                                        "${_reportBloc.myreport[index].duration} h",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ))
            ]);
            // return ;
          },
          listener: (context, state) {
            if (state is FetchedReport) {
              _refreshController.loadComplete();
              _refreshController.refreshCompleted();
            }
            if (state is EndOfReportList) {
              _refreshController.loadNoData();
            }
          }),
    );
  }

  showPickerDateRange(BuildContext context) {
    String? _startDate;
    String? _endDate;

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    Picker ps = Picker(
        confirmText: "Confirm",
        cancelText: "Cancel",
        hideHeader: true,
        adapter: DateTimePickerAdapter(
            type: PickerDateTimeType.kYMD, isNumberMonth: false),
        onConfirm: (Picker picker, List value) {
          _startDate = formatter
              .format((picker.adapter as DateTimePickerAdapter).value!);
        });

    Picker pe = Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(type: PickerDateTimeType.kYMD),
        onConfirm: (Picker picker, List value) {
          _endDate = formatter
              .format((picker.adapter as DateTimePickerAdapter).value!);
        });

    List<Widget> actions = [
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(PickerLocalizations.of(context).cancelText!)),
      TextButton(
          onPressed: () {
            Navigator.pop(context);
            ps.onConfirm!(ps, ps.selecteds);
            pe.onConfirm!(pe, pe.selecteds);
            _reportBloc.add(InitailizeAttendanceStarted(
                dateRange: "$_startDate/$_endDate", isSecond: true));
          },
          child: Text(PickerLocalizations.of(context).confirmText!))
    ];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Date"),
            actions: actions,
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Start :"),
                  ps.makePicker(),
                  Text("End :"),
                  pe.makePicker()
                ],
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    _reportBloc.close();
    _refreshController.dispose();
    super.dispose();
  }
}
