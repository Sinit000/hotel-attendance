import 'package:e_learning/src/feature/report/bloc/index.dart';
import 'package:e_learning/src/feature/report/bloc/report_bloc.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';

import '../../../../appLocalizations.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: standardAppBar(context,
      //     "${AppLocalizations.of(context)!.translate("report_page")!}"),
      body: ReportBody(),
    );
  }
}

class ReportBody extends StatefulWidget {
  const ReportBody({Key? key}) : super(key: key);

  @override
  State<ReportBody> createState() => _ReportBodyState();
}

class _ReportBodyState extends State<ReportBody> {
  ReportBloc _reportBloc = ReportBloc();
  final RefreshController _refreshController = RefreshController();
  String mydateRage = "This week";
  @override
  void initState() {
    _reportBloc.add(FetchReportStarted(
      dateRange: mydateRage,
    ));
    // _reportBloc.myreport.clear();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: _reportBloc,
        builder: (context, state) {
          print(state);
          if (state is FetchingReport) {
            return Center(
              // child: CircularProgressIndicator(),
              child: Lottie.asset('assets/animation/loader.json',
                  width: 200, height: 200),
            );
          }
          if (state is ErrorFetchingReport) {
            return Center(
              child: TextButton(
                  onPressed: () {
                    _reportBloc.add(FetchReportStarted(dateRange: mydateRage));
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.teal,
                    onSurface: Colors.grey,
                  ),
                  child: Text(
                      "${AppLocalizations.of(context)!.translate("no_data")!}")),
            );
          } else {
            // print(_reportBloc.dateRange!);
            return Column(
              children: [
                // user condition to avoid null and cause error while data is fetching
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
                                mydateRage = value!;
                                print("myvalue $mydateRage");
                                print(mydateRage);
                              });
                              _reportBloc.add(
                                  FetchReportStarted(dateRange: mydateRage));
                            }
                          },
                        ),
                      ),
                Container(
                  width: double.infinity,
                  height: 10,
                  color: Colors.transparent,
                ),
                _reportBloc.reportModel == null
                    ? Container(
                        child: Text("No data"),
                      )
                    : Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: 1.0,
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                            children: [
                              _buildReportItem(
                                  title: AppLocalizations.of(context)!
                                      .translate("attendance")!,
                                  text:
                                      "${_reportBloc.reportModel!.attendance}"),
                              _buildReportItem(
                                  title: AppLocalizations.of(context)!
                                      .translate("absent")!,
                                  text: "${_reportBloc.reportModel!.absent}"),
                              _buildReportItem(
                                  title: AppLocalizations.of(context)!
                                      .translate("leave")!,
                                  text: "${_reportBloc.reportModel!.leave}"),
                              _buildReportItem(
                                  title: AppLocalizations.of(context)!
                                      .translate("leave_deduction")!,
                                  text:
                                      "${_reportBloc.reportModel!.leaveDeduction}"),
                              _buildReportItem(
                                  title: AppLocalizations.of(context)!
                                      .translate("leave_out")!,
                                  text: "${_reportBloc.reportModel!.leaveout}"),
                              _buildReportItem(
                                  title: AppLocalizations.of(context)!
                                      .translate("total_ot")!,
                                  text: "${_reportBloc.reportModel!.totalOt}"),
                              _buildReportItem(
                                  title: AppLocalizations.of(context)!
                                      .translate("otHour")!,
                                  text: "${_reportBloc.reportModel!.otHour}"),
                              _buildReportItem(
                                  title: AppLocalizations.of(context)!
                                      .translate("ot_cash")!,
                                  text: "${_reportBloc.reportModel!.otCash}"),
                              _buildReportItem(
                                  title: AppLocalizations.of(context)!
                                      .translate("ot_holiday")!,
                                  text: "${_reportBloc.reportModel!.holiday}"),

                              // Container(
                              //   alignment: Alignment.center,
                              //   margin: EdgeInsets.all(30.0),
                              //   decoration: BoxDecoration(
                              //       color: Colors.green,
                              //       borderRadius: BorderRadius.circular(20)),
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: <Widget>[
                              //       Text("Data"),
                              //       SizedBox(
                              //         height: 10.0,
                              //       ),
                              //       Text("Sinit")
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      )
                // : Expanded(
                //     child: SmartRefresher(
                //     onRefresh: () {
                //       print("fetch dateRange");
                //       print(mydateRage);
                //       // _reportBloc.add(InitailizeReportStarted(
                //       //     dateRange: mydateRage, isRefresh: 'yes'));
                //     },
                //     onLoading: () {
                //       print("fetch dateRange");
                //       print(mydateRage);
                //       // _reportBloc
                //       //     .add(FetchReportStarted(dateRange: mydateRage));
                //     },
                //     enablePullDown: true,
                //     enablePullUp: true,
                //     controller: _refreshController,
                //     child: SingleChildScrollView(
                //       child: Column(
                //         // addAutomaticKeepAlives: true,
                //         children: [
                //           ListView.builder(
                //             cacheExtent: 1000,
                //             physics: NeverScrollableScrollPhysics(),
                //             shrinkWrap: true,
                //             // padding: EdgeInsets.only(left: 10, top: 10, right: 0),

                //             itemCount: _reportBloc.myreport.length,
                //             itemBuilder: (context, index) {
                //               return Container(
                //                 margin: EdgeInsets.only(
                //                     bottom: 10.0, left: 8.0, right: 8.0),
                //                 decoration: BoxDecoration(
                //                   border: Border.all(
                //                       color: Colors.grey.withOpacity(0.2)),
                //                   borderRadius: BorderRadius.circular(6.0),
                //                   color: Colors.white,
                //                   boxShadow: [
                //                     BoxShadow(
                //                       color: Colors.grey.withOpacity(0.5),
                //                       spreadRadius: 0,
                //                       blurRadius: 3,
                //                       offset: Offset(0,
                //                           0), // changes position of shadow
                //                     ),
                //                   ],
                //                 ),
                //                 child: Container(
                //                   padding: EdgeInsets.all(8.0),
                //                   child: Column(
                //                     mainAxisSize: MainAxisSize.min,
                //                     children: [
                //                       Row(
                //                         // mainAxisAlignment:
                //                         //     MainAxisAlignment.spaceBetween,
                //                         children: [
                //                           Padding(
                //                             padding: const EdgeInsets.only(
                //                                 right: 10),
                //                             child: Text(
                //                               "${AppLocalizations.of(context)!.translate("date")!} :",
                //                               style: TextStyle(
                //                                   color: Colors.black),
                //                             ),
                //                           ),
                //                           Text(
                //                             "${_reportBloc.myreport[index].date}",
                //                             style: TextStyle(
                //                                 color: Colors.green,
                //                                 fontWeight:
                //                                     FontWeight.bold),
                //                           )
                //                         ],
                //                       ),
                //                       _reportBloc.myreport[index].status ==
                //                                   "leave" ||
                //                               _reportBloc.myreport[index]
                //                                       .status ==
                //                                   "absent"
                //                           ? Container()
                //                           : SizedBox(
                //                               height: 5.0,
                //                             ),
                //                       _reportBloc.myreport[index].status ==
                //                                   "leave" ||
                //                               _reportBloc.myreport[index]
                //                                       .status ==
                //                                   "absent"
                //                           ? Container()
                //                           : Row(
                //                               children: [
                //                                 Padding(
                //                                   padding:
                //                                       const EdgeInsets.only(
                //                                           right: 8),
                //                                   child: Text(
                //                                     "${AppLocalizations.of(context)!.translate("checkin_time")!} :",
                //                                     style: TextStyle(
                //                                         color:
                //                                             Colors.black),
                //                                   ),
                //                                 ),
                //                                 Row(
                //                                   children: [
                //                                     Text(
                //                                       "${_reportBloc.myreport[index].checkinTime} ",
                //                                       style: TextStyle(
                //                                           color: Colors.red,
                //                                           fontWeight:
                //                                               FontWeight
                //                                                   .bold),
                //                                     ),
                //                                     // Text("- "),
                //                                     // Text(
                //                                     //   " ${BlocProvider.of<WantedBloc>(context).wantedList[index].maxPrice}",
                //                                     //   style: TextStyle(
                //                                     //       color: Colors.red,
                //                                     //       fontWeight: FontWeight.bold),
                //                                     // ),
                //                                   ],
                //                                 ),
                //                               ],
                //                             ),
                //                       _reportBloc.myreport[index].status ==
                //                                   "leave" ||
                //                               _reportBloc.myreport[index]
                //                                       .status ==
                //                                   "absent"
                //                           ? Container()
                //                           : SizedBox(
                //                               height: 5.0,
                //                             ),
                //                       _reportBloc.myreport[index].status ==
                //                                   "leave" ||
                //                               _reportBloc.myreport[index]
                //                                       .status ==
                //                                   "absent"
                //                           ? Container()
                //                           : Row(
                //                               children: [
                //                                 Padding(
                //                                   padding:
                //                                       const EdgeInsets.only(
                //                                           right: 8),
                //                                   child: Text(
                //                                     "${AppLocalizations.of(context)!.translate("checkin_status")!} :",
                //                                     style: TextStyle(
                //                                         color:
                //                                             Colors.black),
                //                                   ),
                //                                 ),
                //                                 Text(
                //                                   "${_reportBloc.myreport[index].checkitStatus} ${_reportBloc.myreport[index].checkinLate} mn",
                //                                   style: TextStyle(
                //                                       color: Colors.purple),
                //                                 ),
                //                               ],
                //                             ),
                //                       _reportBloc.myreport[index].status ==
                //                                   "leave" ||
                //                               _reportBloc.myreport[index]
                //                                       .status ==
                //                                   "absent"
                //                           ? Container()
                //                           : SizedBox(
                //                               height: 5.0,
                //                             ),
                //                       _reportBloc.myreport[index].status ==
                //                                   "leave" ||
                //                               _reportBloc.myreport[index]
                //                                       .status ==
                //                                   "absent"
                //                           ? Container()
                //                           : Row(
                //                               children: [
                //                                 Padding(
                //                                   padding:
                //                                       const EdgeInsets.only(
                //                                           right: 8),
                //                                   child: Text(
                //                                     "${AppLocalizations.of(context)!.translate("checkout_time")!} :",
                //                                     style: TextStyle(
                //                                         color:
                //                                             Colors.black),
                //                                   ),
                //                                 ),
                //                                 _reportBloc.myreport[index]
                //                                             .checkoutTime ==
                //                                         null
                //                                     ? Text("")
                //                                     : Text(
                //                                         "${_reportBloc.myreport[index].checkoutTime}",
                //                                       ),
                //                               ],
                //                             ),
                //                       _reportBloc.myreport[index].status ==
                //                                   "leave" ||
                //                               _reportBloc.myreport[index]
                //                                       .status ==
                //                                   "absent"
                //                           ? Container()
                //                           : SizedBox(
                //                               height: 5.0,
                //                             ),
                //                       _reportBloc.myreport[index].status ==
                //                                   "leave" ||
                //                               _reportBloc.myreport[index]
                //                                       .status ==
                //                                   "absent"
                //                           ? Container()
                //                           : Row(
                //                               children: [
                //                                 Padding(
                //                                   padding:
                //                                       const EdgeInsets.only(
                //                                           right: 8),
                //                                   child: Text(
                //                                     "${AppLocalizations.of(context)!.translate("checkout_status")!} :",
                //                                     style: TextStyle(
                //                                         color:
                //                                             Colors.black),
                //                                   ),
                //                                 ),
                //                                 _reportBloc.myreport[index]
                //                                             .checkoutStatus ==
                //                                         null
                //                                     ? Text("")
                //                                     : Text(
                //                                         "${_reportBloc.myreport[index].checkoutStatus}  ${_reportBloc.myreport[index].checkoutLate}",
                //                                       ),
                //                               ],
                //                             ),
                //                       SizedBox(
                //                         height: 5.0,
                //                       ),
                //                       Row(
                //                         children: [
                //                           Padding(
                //                             padding: const EdgeInsets.only(
                //                                 right: 8),
                //                             child: Text(
                //                               "${AppLocalizations.of(context)!.translate("status")!} :",
                //                               style: TextStyle(
                //                                   color: Colors.black),
                //                             ),
                //                           ),
                //                           Text(
                //                             "${_reportBloc.myreport[index].status} ",
                //                             style: TextStyle(
                //                                 color: Colors.red),
                //                           ),
                //                         ],
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               );
                //             },
                //           ),
                //         ],
                //       ),
                //     ),
                //   )),
              ],
            );
          }
          // return Center();
        },
        listener: (context, state) {
          if (state is FetchedReport) {
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
          }
          if (state is EndOfReportList) {
            _refreshController.loadNoData();
          }
        });
  }

  _buildReportItem({required String title, required String text}) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Colors.green[300], borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "$title",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textScaleFactor: 1.2,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text("$text",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))
        ],
      ),
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
            _reportBloc
                .add(FetchReportStarted(dateRange: "$_startDate/$_endDate"));
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
    // _refreshController.dispose();
    super.dispose();
  }
}
