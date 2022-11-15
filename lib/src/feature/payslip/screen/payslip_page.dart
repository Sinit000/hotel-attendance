import 'package:e_learning/src/feature/overtime/bloc/overtime_bloc.dart';
import 'package:e_learning/src/feature/payslip/bloc/index.dart';
import 'package:e_learning/src/feature/payslip/screen/payslip_detail.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../appLocalizations.dart';

import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';

class PayslipPage extends StatelessWidget {
  const PayslipPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(
          context, "${AppLocalizations.of(context)!.translate("payslip")!}"),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10), child: Body()),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PayslipBloc _payslipBloc = PayslipBloc();
  final RefreshController _refreshController = RefreshController();
  String mydateRage = "This year";
  @override
  void initState() {
    _payslipBloc
        .add(InitailizePayslipStarted(dateRange: "This year", isSecond: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: _payslipBloc,
        builder: (context, state) {
          print(state);

          if (state is InitailizingPayslip) {
            return Center(
              child: Lottie.asset('assets/animation/loader.json',
                  width: 200, height: 200),
            );
          }
          if (state is ErrorFetchingPayslip) {
            return Center(
              child: TextButton(
                  onPressed: () {
                    _payslipBloc.add(InitailizePayslipStarted(
                        dateRange: "This year", isSecond: true));
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.teal,
                    onSurface: Colors.grey,
                  ),
                  child: Text(
                      "${AppLocalizations.of(context)!.translate("retry")!}")),
            );
            // return Center(
            //   child: Text(state.error.toString()),
            // );
          } else {
            // print(_reportBloc.dateRange!);
            return Column(
              children: [
                // user condition to avoid null and cause error while data is fetching
                _payslipBloc.dateRange == null
                    ? Container()
                    : Container(
                        padding: EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        child: DropdownButton<String>(
                          hint: _payslipBloc.dateRange!.contains("to")
                              ? Text("${_payslipBloc.dateRange!}")
                              : Text(
                                  // leaveBloc.dateRange!,
                                  // _reportBloc.dateRange!.contains("to")
                                  //     ? _reportBloc.dateRange!
                                  //     :W
                                  "${_payslipBloc.dateRange!}",
                                  textScaleFactor: 1,
                                ),
                          items: [
                            // 'Last year',
                            'This year',
                            // 'Next year',
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
                            } else {
                              setState(() {
                                mydateRage = value!;
                                print("myvalue $mydateRage");
                                print(mydateRage);
                              });
                              _payslipBloc.add(InitailizePayslipStarted(
                                  dateRange: value, isSecond: true));
                            }
                          },
                        ),
                      ),
                Container(
                  width: double.infinity,
                  height: 10,
                  color: Colors.transparent,
                ),
                _payslipBloc.payslip.length == 0
                    ? Container(
                        child: Text(
                            "${AppLocalizations.of(context)!.translate("no_data")!}"),
                      )
                    : Expanded(
                        child: SmartRefresher(
                        onRefresh: () {
                          print("fetch dateRange");
                          print(mydateRage);
                          _payslipBloc.add(InitailizePayslipStarted(
                              dateRange: mydateRage, isRefresh: 'yes'));
                        },
                        onLoading: () {
                          print("fetch dateRange");
                          print(mydateRage);
                          _payslipBloc
                              .add(FetchPayslipStarted(dateRange: mydateRage));
                        },
                        enablePullDown: true,
                        enablePullUp: true,
                        controller: _refreshController,
                        child: SingleChildScrollView(
                          child: Column(
                            // addAutomaticKeepAlives: true,
                            children: [
                              ListView.builder(
                                cacheExtent: 1000,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                // padding: EdgeInsets.only(left: 10, top: 10, right: 0),

                                itemCount: _payslipBloc.payslip.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PayslipDetail(
                                                    payslipModel: _payslipBloc
                                                        .payslip[index],
                                                  )));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        // border: Border.all(
                                        //     color:
                                        //         Colors.grey.withOpacity(0.2)),
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        color: Colors.blue.withOpacity(0.2),
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     color: Colors.grey.withOpacity(0.5),
                                        //     spreadRadius: 0,
                                        //     blurRadius: 3,
                                        //     offset: Offset(0,
                                        //         0), // changes position of shadow
                                        //   ),
                                        // ],
                                      ),

                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, bottom: 10),
                                      // color: Colors.redAccent,
                                      height: 90,
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                // padding: EdgeInsets.only(left: 10),
                                                margin: EdgeInsets.only(
                                                    left: 10, top: 15),
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.orangeAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(50),

                                                  // image: DecorationImage(
                                                  //     fit: BoxFit.cover,
                                                  //     image: AssetImage(
                                                  //       "${paylist[index].image}",
                                                  //     ))
                                                ),
                                                child: Center(
                                                  child: _payslipBloc
                                                              .payslip[index]
                                                              .month ==
                                                          "January"
                                                      ? Text(
                                                          "01".toUpperCase(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                          textScaleFactor: 1.5,
                                                        )
                                                      : _payslipBloc
                                                                  .payslip[
                                                                      index]
                                                                  .month ==
                                                              "February"
                                                          ? Text(
                                                              "02".toUpperCase(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                              textScaleFactor:
                                                                  1.5,
                                                            )
                                                          : _payslipBloc
                                                                      .payslip[
                                                                          index]
                                                                      .month ==
                                                                  "March"
                                                              ? Text(
                                                                  "03".toUpperCase(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                  textScaleFactor:
                                                                      1.5,
                                                                )
                                                              : _payslipBloc
                                                                          .payslip[
                                                                              index]
                                                                          .month ==
                                                                      "April"
                                                                  ? Text(
                                                                      "04".toUpperCase(),
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                      textScaleFactor:
                                                                          1.5,
                                                                    )
                                                                  : _payslipBloc
                                                                              .payslip[
                                                                                  index]
                                                                              .month ==
                                                                          "May"
                                                                      ? Text(
                                                                          "05".toUpperCase(),
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                          textScaleFactor:
                                                                              1.5,
                                                                        )
                                                                      : _payslipBloc.payslip[index].month ==
                                                                              "June"
                                                                          ? Text(
                                                                              "06".toUpperCase(),
                                                                              style: TextStyle(color: Colors.white),
                                                                              textScaleFactor: 1.5,
                                                                            )
                                                                          : _payslipBloc.payslip[index].month == "July"
                                                                              ? Text(
                                                                                  "07".toUpperCase(),
                                                                                  style: TextStyle(color: Colors.white),
                                                                                  textScaleFactor: 1.5,
                                                                                )
                                                                              : _payslipBloc.payslip[index].month == "August"
                                                                                  ? Text(
                                                                                      "08".toUpperCase(),
                                                                                      style: TextStyle(color: Colors.white),
                                                                                      textScaleFactor: 1.5,
                                                                                    )
                                                                                  : _payslipBloc.payslip[index].month == "September"
                                                                                      ? Text(
                                                                                          "09".toUpperCase(),
                                                                                          style: TextStyle(color: Colors.white),
                                                                                          textScaleFactor: 1.5,
                                                                                        )
                                                                                      : _payslipBloc.payslip[index].month == "October"
                                                                                          ? Text(
                                                                                              "10".toUpperCase(),
                                                                                              style: TextStyle(color: Colors.white),
                                                                                              textScaleFactor: 1.5,
                                                                                            )
                                                                                          : _payslipBloc.payslip[index].month == "November"
                                                                                              ? Text(
                                                                                                  "11".toUpperCase(),
                                                                                                  style: TextStyle(color: Colors.white),
                                                                                                  textScaleFactor: 1.5,
                                                                                                )
                                                                                              : _payslipBloc.payslip[index].month == "December"
                                                                                                  ? Text(
                                                                                                      "12".toUpperCase(),
                                                                                                      style: TextStyle(color: Colors.white),
                                                                                                      textScaleFactor: 1.5,
                                                                                                    )
                                                                                                  : Text(
                                                                                                      "12".toUpperCase(),
                                                                                                      style: TextStyle(color: Colors.white),
                                                                                                      textScaleFactor: 1.5,
                                                                                                    ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 15),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${_payslipBloc.payslip[index].month}",
                                                      textScaleFactor: 1.2,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 3),
                                                      child: Text(
                                                        "${_payslipBloc.payslip[index].fromDate} - ${_payslipBloc.payslip[index].toDate}",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[500],
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    // Padding(
                                                    //   padding: EdgeInsets.only(top: 3),
                                                    //   child: Text(
                                                    //     "\$1200",
                                                    //     style: TextStyle(color: Colors.redAccent),
                                                    //   ),
                                                    // )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              // InkWell(
                                              //   child: Icon(Icons.navigate_next),
                                              // )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
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
                                          offset: Offset(0,
                                              0), // changes position of shadow
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
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  "${AppLocalizations.of(context)!.translate("from_date")!} : ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Text(
                                                "${_payslipBloc.payslip[index].fromDate}",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Row(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  "${AppLocalizations.of(context)!.translate("to_date")!} : ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Text(
                                                "${_payslipBloc.payslip[index].toDate}",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Text(
                                                  "${AppLocalizations.of(context)!.translate("base_salary")!} : ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${_payslipBloc.payslip[index].baseSalary} ",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                          // SizedBox(
                                          //   height: 5.0,
                                          // ),
                                          // Row(
                                          //   children: [
                                          //     Padding(
                                          //       padding: const EdgeInsets.only(
                                          //           right: 8),
                                          //       child: Text(
                                          //         "${AppLocalizations.of(context)!.translate("duration")!} : ",
                                          //         style: TextStyle(
                                          //             color: Colors.black),
                                          //       ),
                                          //     ),
                                          //     Text(
                                          //       "${leaveBloc.myleave[index].number}",
                                          //     ),
                                          //   ],
                                          // ),
                                          // SizedBox(
                                          //   height: 5.0,
                                          // ),
                                          // Row(
                                          //   children: [
                                          //     Padding(
                                          //       padding: const EdgeInsets.only(
                                          //           right: 8),
                                          //       child: Text(
                                          //         "${AppLocalizations.of(context)!.translate("from_date")!} : ",
                                          //         style: TextStyle(
                                          //             color: Colors.black),
                                          //       ),
                                          //     ),
                                          //     Text(
                                          //       "${leaveBloc.myleave[index].fromDate}",
                                          //     ),
                                          //   ],
                                          // ),
                                          // SizedBox(
                                          //   height: 5.0,
                                          // ),
                                          // Row(
                                          //   children: [
                                          //     Padding(
                                          //       padding: const EdgeInsets.only(
                                          //           right: 8),
                                          //       child: Text(
                                          //         "${AppLocalizations.of(context)!.translate("to_date")!} : ",
                                          //         style: TextStyle(
                                          //             color: Colors.black),
                                          //       ),
                                          //     ),
                                          //     Text(
                                          //       "${leaveBloc.myleave[index].toDate}",
                                          //     ),
                                          //   ],
                                          // ),
                                          // SizedBox(
                                          //   height: 5.0,
                                          // ),
                                          // Row(
                                          //   children: [
                                          //     Padding(
                                          //       padding: const EdgeInsets.only(
                                          //           right: 8),
                                          //       child: Text(
                                          //         "${AppLocalizations.of(context)!.translate("status")!} : ",
                                          //         style: TextStyle(
                                          //             color: Colors.black),
                                          //       ),
                                          //     ),
                                          //     Text(
                                          //       "${leaveBloc.myleave[index].status}",
                                          //       style: TextStyle(
                                          //           color: Colors.red),
                                          //     ),
                                          //   ],
                                          // ),
                                          // leaveBloc.myleave[index].status ==
                                          //         "pending"
                                          //     ? Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment.end,
                                          //         children: [
                                          //           CupertinoButton(
                                          //               padding:
                                          //                   EdgeInsets.all(1.0),
                                          //               color: Colors.green,
                                          //               child: Row(
                                          //                 children: [
                                          //                   Icon(Icons.edit),
                                          //                 ],
                                          //               ),
                                          //               onPressed: () {
                                          //                 Navigator.push(
                                          //                     context,
                                          //                     MaterialPageRoute(
                                          //                         builder: (con) =>
                                          //                             EditLeave(
                                          //                               leaveModel:
                                          //                                   leaveBloc.myleave[index],
                                          //                             )));
                                          //               }),
                                          //           SizedBox(
                                          //             width: 5,
                                          //           ),
                                          //           CupertinoButton(
                                          //               padding:
                                          //                   EdgeInsets.all(1.0),
                                          //               color: Colors.red,
                                          //               child: Row(
                                          //                 children: [
                                          //                   Icon(Icons.delete),
                                          //                 ],
                                          //               ),
                                          //               onPressed: () {
                                          //                 showDialog(
                                          //                     context: context,
                                          //                     builder:
                                          //                         (BuildContext
                                          //                             context) {
                                          //                       return AlertDialog(
                                          //                         title: Text(
                                          //                             'Alert'),
                                          //                         content: Text(
                                          //                             "Do want to delete this record?"),
                                          //                         actions: <
                                          //                             Widget>[
                                          //                           FlatButton(
                                          //                             onPressed:
                                          //                                 () {
                                          //                               Navigator.pop(
                                          //                                   context);
                                          //                             },
                                          //                             child: Text(
                                          //                                 'No',
                                          //                                 style:
                                          //                                     TextStyle(color: Colors.red)),
                                          //                           ),
                                          //                           FlatButton(
                                          //                             onPressed:
                                          //                                 () {
                                          //                               print(
                                          //                                   "id ${leaveBloc.myleave[index].id}");
                                          //                               leaveBloc
                                          //                                   .add(DeleteLeaveStarted(id: leaveBloc.myleave[index].id));
                                          //                               Navigator.pop(
                                          //                                   context);
                                          //                             },
                                          //                             child:
                                          //                                 Text(
                                          //                               'Yes',
                                          //                               style: TextStyle(
                                          //                                   color:
                                          //                                       Colors.blue),
                                          //                             ),
                                          //                           ),
                                          //                         ],
                                          //                       );
                                          //                     });
                                          //               }),
                                          //         ],
                                          //       )
                                          //     : leaveBloc.myleave[index]
                                          //                 .status ==
                                          //             "rejected"
                                          //         ? Container()
                                          //         : Container(),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      )),
              ],
            );
          }
          // return Center();
        },
        listener: (context, state) {
          print("state");
          print(state);
          if (state is FetchedPayslip) {
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
          }
          if (state is EndofPayslip) {
            _refreshController.loadNoData();
          }
        });
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
            _payslipBloc.add(InitailizePayslipStarted(
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
}
