import 'package:e_learning/src/config/routes/routes.dart';
import 'package:e_learning/src/feature/auth/bloc/index.dart';
import 'package:e_learning/src/feature/permission/bloc/index.dart';
import 'package:e_learning/src/shared/widget/delete_dialog.dart';
import 'package:e_learning/src/shared/widget/error_snackbar.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../appLocalizations.dart';
import 'edit_leave.dart';
import 'leave_page.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';

class MyLeave extends StatelessWidget {
  const MyLeave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(
          context, "${AppLocalizations.of(context)!.translate("my_leave")!}"),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10), child: LeaveBody()),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.lightBlueAccent,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {
              Navigator.pushNamed(context, addLeave);
            }),
      ),
    );
  }
}

class LeaveBody extends StatefulWidget {
  // final String mydate;
  // const LeaveBody({required this.mydate});
  @override
  State<LeaveBody> createState() => _LeaveBodyState();
}

class _LeaveBodyState extends State<LeaveBody> {
  final RefreshController _refreshController = RefreshController();
  String mydateRage = "This month";
  @override
  void initState() {
    leaveBloc
        .add(InitializeLeaveStarted(dateRange: mydateRage, isSecond: false));
    // leaveBloc.add(FetchLeaveTypeStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LeaveBloc>(context).add(FetchLeaveTypeStarted());
    return BlocConsumer(
        bloc: leaveBloc,
        builder: (context, state) {
          print(state);

          if (state is InitializingLeave) {
            return Center(
              child: Lottie.asset('assets/animation/loader.json',
                  width: 200, height: 200),
            );
          }
          if (state is ErrorFetchingLeave) {
            return Center(
              child: TextButton(
                  onPressed: () {
                    leaveBloc.add(InitializeLeaveStarted(
                        dateRange: mydateRage, isSecond: true));
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.teal,
                    onSurface: Colors.grey,
                  ),
                  child: Text("Retry")),
            );
          } else {
            // print(_reportBloc.dateRange!);
            return Column(
              children: [
                // user condition to avoid null and cause error while data is fetching
                leaveBloc.dateRange == null
                    ? Container()
                    : Container(
                        padding: EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        child: DropdownButton<String>(
                          hint: leaveBloc.dateRange!.contains("to")
                              ? Text("${leaveBloc.dateRange!}")
                              : Text(
                                  // leaveBloc.dateRange!,
                                  // _reportBloc.dateRange!.contains("to")
                                  //     ? _reportBloc.dateRange!
                                  //     :W
                                  "${leaveBloc.dateRange!}",
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
                            } else {
                              setState(() {
                                mydateRage = value!;
                                print("myvalue $mydateRage");
                                print(mydateRage);
                              });
                              leaveBloc.add(InitializeLeaveStarted(
                                  dateRange: mydateRage, isSecond: true));
                            }
                          },
                        ),
                      ),
                Container(
                  width: double.infinity,
                  height: 10,
                  color: Colors.transparent,
                ),
                leaveBloc.myleave.length == 0
                    ? Container(
                        child: Text("No data"),
                      )
                    : Expanded(
                        child: SmartRefresher(
                        onRefresh: () {
                          print("fetch dateRange");
                          print(mydateRage);
                          leaveBloc.add(InitializeLeaveStarted(
                              dateRange: mydateRage, isRefresh: 'yes'));
                        },
                        onLoading: () {
                          print("fetch dateRange");
                          print(mydateRage);
                          leaveBloc
                              .add(FetchLeaveStarted(dateRange: mydateRage));
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

                                itemCount: leaveBloc.myleave.length,
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
                                                  "${AppLocalizations.of(context)!.translate("date")!} : ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Text(
                                                "${leaveBloc.myleave[index].date}",
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
                                                  "${AppLocalizations.of(context)!.translate("reason")!} : ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${leaveBloc.myleave[index].reason} ",
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
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Text(
                                                  "${AppLocalizations.of(context)!.translate("type_one")!} : ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Text(
                                                "${leaveBloc.myleave[index].type}",
                                              ),
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
                                                  "${AppLocalizations.of(context)!.translate("duration")!} : ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Text(
                                                "${leaveBloc.myleave[index].number}",
                                              ),
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
                                                  "${AppLocalizations.of(context)!.translate("from_date")!} : ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Text(
                                                "${leaveBloc.myleave[index].fromDate}",
                                              ),
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
                                                  "${AppLocalizations.of(context)!.translate("to_date")!} : ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Text(
                                                "${leaveBloc.myleave[index].toDate}",
                                              ),
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
                                                  "${AppLocalizations.of(context)!.translate("status")!} : ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Text(
                                                "${leaveBloc.myleave[index].status}",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
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
                                                  "${AppLocalizations.of(context)!.translate("leave_deduction")!} : ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              leaveBloc.myleave[index]
                                                          .leaveDeduction ==
                                                      null
                                                  ? Text(
                                                      "\$0",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    )
                                                  : Text(
                                                      "\$${leaveBloc.myleave[index].leaveDeduction}",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                            ],
                                          ),
                                          leaveBloc.myleave[index].status ==
                                                  "pending"
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    CupertinoButton(
                                                        padding:
                                                            EdgeInsets.all(1.0),
                                                        color: Colors.green,
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.edit),
                                                          ],
                                                        ),
                                                        onPressed: () {
                                                          // compared leavetype id = parent_id for special leave
                                                          String typeId = "";
                                                          // print(
                                                          //     "length ${leaveBloc.leaveList.length}");
                                                          for (int i = 0;
                                                              i <
                                                                  BlocProvider.of<
                                                                              LeaveBloc>(
                                                                          context)
                                                                      .leaveList
                                                                      .length;
                                                              i++) {
                                                            if (BlocProvider.of<
                                                                            LeaveBloc>(
                                                                        context)
                                                                    .leaveList[
                                                                        i]
                                                                    .id ==
                                                                leaveBloc
                                                                    .myleave[
                                                                        index]
                                                                    .leaveTypeModel!
                                                                    .parentId) {
                                                              print("hi sis");
                                                              typeId = BlocProvider
                                                                      .of<LeaveBloc>(
                                                                          context)
                                                                  .leaveList[i]
                                                                  .leaveType;
                                                            }
                                                          }

                                                          print(
                                                              "parent $typeId");
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (con) =>
                                                                      EditLeave(
                                                                        parent:
                                                                            typeId,
                                                                        leaveModel:
                                                                            leaveBloc.myleave[index],
                                                                      )));
                                                        }),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    CupertinoButton(
                                                        padding:
                                                            EdgeInsets.all(1.0),
                                                        color: Colors.red,
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.delete),
                                                          ],
                                                        ),
                                                        onPressed: () {
                                                          deleteDialog(
                                                              context: context,
                                                              onPress: () {
                                                                print(
                                                                    "id ${leaveBloc.myleave[index].id}");
                                                                leaveBloc.add(DeleteLeaveStarted(
                                                                    id: leaveBloc
                                                                        .myleave[
                                                                            index]
                                                                        .id));
                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                        }),
                                                  ],
                                                )
                                              : leaveBloc.myleave[index]
                                                          .status ==
                                                      "rejected"
                                                  ? Container()
                                                  : Container(),
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
          if (state is FetchedLeave) {
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
          }
          if (state is EndOfLeaveList) {
            _refreshController.loadNoData();
          }
          if (state is AddingLeave) {
            EasyLoading.show(status: "loading....");
          }
          if (state is ErrorAddingLeave) {
            EasyLoading.dismiss();
            errorSnackBar(text: state.error.toString(), context: context);
          }
          if (state is AddedLeave) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess("Sucess");
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
            leaveBloc.add(
                InitializeLeaveStarted(dateRange: "$_startDate/$_endDate"));
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
