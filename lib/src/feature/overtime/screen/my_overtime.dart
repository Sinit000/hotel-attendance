import 'package:e_learning/src/feature/auth/bloc/index.dart';
import 'package:e_learning/src/feature/overtime/bloc/index.dart';
import 'package:e_learning/src/feature/overtime/model/overtime_model.dart';
import 'package:e_learning/src/shared/widget/custome_modal.dart';
import 'package:e_learning/src/shared/widget/delete_dialog.dart';
import 'package:e_learning/src/shared/widget/error_snackbar.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../appLocalizations.dart';
import 'overtime_page.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';

class MyOvertime extends StatelessWidget {
  const MyOvertime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(
          context, "${AppLocalizations.of(context)!.translate("my_ot")!}"),
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
  final RefreshController _refreshController = RefreshController();

  List<String> _mylist = ['Approve', 'Reject'];
  List<String> _payType = ['cash', 'holiday'];
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _payTypeCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  String mydateRage = "This month";
  bool isEnable = false;
  @override
  void initState() {
    overtimeBloc.add(
        InitailzeMyOvertimeStarted(dateRange: "This month", isSecond: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: overtimeBloc,
        builder: (context, state) {
          print(state);
          //  return Center(child: CircularProgressIndicator());
          if (state is InitailizingOvertime) {
            return Center(
              // child: CircularProgressIndicator(),
              child: Lottie.asset('assets/animation/loader.json',
                  width: 200, height: 200),
            );
          }
          if (state is ErrorFetchingOvertime) {
            return Center(
              child: TextButton(
                  onPressed: () {
                    overtimeBloc.add(InitailzeMyOvertimeStarted(
                        dateRange: "This month", isSecond: true));
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
                overtimeBloc.dateRange == null
                    ? Container()
                    : Container(
                        padding: EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        child: DropdownButton<String>(
                          hint: overtimeBloc.dateRange!.contains("to")
                              ? Text("${overtimeBloc.dateRange!}")
                              : Text(
                                  // leaveBloc.dateRange!,
                                  // _reportBloc.dateRange!.contains("to")
                                  //     ? _reportBloc.dateRange!
                                  //     :W
                                  "${overtimeBloc.dateRange!}",
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
                              overtimeBloc.add(InitailzeMyOvertimeStarted(
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
                overtimeBloc.myovertime.length == 0
                    ? Container(
                        child: Text(
                            "${AppLocalizations.of(context)!.translate("retry")!}"),
                      )
                    : Expanded(
                        child: SmartRefresher(
                        onRefresh: () {
                          print("fetch dateRange");
                          print(mydateRage);
                          overtimeBloc.add(InitailzeMyOvertimeStarted(
                              dateRange: mydateRage, isRefresh: 'yes'));
                        },
                        onLoading: () {
                          print("fetch dateRange");
                          print(mydateRage);
                          overtimeBloc.add(
                              FetchMyOvertimeStarted(dateRange: mydateRage));
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

                                itemCount: overtimeBloc.myovertime.length,
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
                                                "${overtimeBloc.myovertime[index].date}",
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
                                                    "${overtimeBloc.myovertime[index].reason} ",
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
                                          _buildExpenable(
                                              overtimeBloc.myovertime[index])
                                          // SizedBox(
                                          //   height: 5.0,
                                          // ),
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
          if (state is FetchedOvertime) {
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
          }
          if (state is EndofOvertimeList) {
            _refreshController.loadNoData();
          }
          if (state is AddingOvertime) {
            EasyLoading.show(status: "loading....");
          }
          if (state is ErrorAddingOvertime) {
            EasyLoading.dismiss();
            errorSnackBar(text: state.error.toString(), context: context);
          }
          if (state is AddedOvertime) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess("Sucess");
          }
        });
  }

  _buildExpenable(OvertimeModel overtime) {
    return ExpandableNotifier(
        child: Column(
      children: <Widget>[_expandableItemList(overtime)],
    ));
  }

  _expandableItemList(OvertimeModel overtime) {
    return ScrollOnExpand(
        scrollOnExpand: true,
        scrollOnCollapse: false,
        child: ExpandablePanel(
          theme: const ExpandableThemeData(
            headerAlignment: ExpandablePanelHeaderAlignment.center,
            tapBodyToCollapse: true,
          ),
          header: Builder(
            builder: (c) {
              var controller = ExpandableController.of(c, required: true)!;
              return Text(
                controller.expanded
                    ? "${AppLocalizations.of(context)!.translate("hide")!}"
                    : "${AppLocalizations.of(context)!.translate("show")!}",
                style: Theme.of(context).textTheme.bodyText1,
              );
            },
          ),
          collapsed: Center(),
          expanded: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("duration")!} : ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  overtime.type == "hour"
                      ? Text(
                          "${overtime.duration} hour",
                        )
                      : Text(
                          "${overtime.duration} day",
                        ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              // SizedBox(
              //   height: 5.0,
              // ),
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(right: 8),
              //       child: Text(
              //         "${AppLocalizations.of(context)!.translate("type_ot")!} : ",
              //         style: TextStyle(color: Colors.black),
              //       ),
              //     ),
              //     Text(
              //       "${overtime.type}",
              //     ),
              //   ],
              // ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("from_date")!} : ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${overtime.fromDate}",
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("to_date")!} : ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${overtime.toDate}",
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              overtime.paytype == null
                  ? Container()
                  : Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            "${AppLocalizations.of(context)!.translate("pay_type")!} : ",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Text(
                          "${overtime.paytype}",
                        ),
                      ],
                    ),
              SizedBox(
                height: 5.0,
              ),
              overtime.paytype != "holiday"
                  ? Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            "${AppLocalizations.of(context)!.translate("total_ot")!} : ",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Text(
                          "${overtime.totalOt}",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    )
                  : Row(),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("request")!} : ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${overtime.requestBy}",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("status")!} : ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${overtime.status}",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              overtime.status == "pending"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height:
                              1.4 * (MediaQuery.of(context).size.height / 25),
                          width: 5 * (MediaQuery.of(context).size.width / 15),
                          margin: EdgeInsets.only(bottom: 5, top: 5),
                          child: RaisedButton(
                            elevation: 5.0,
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () {
                              _displayTextInputDialog(context, overtime.id);
                            },
                            child: Text(
                              "${AppLocalizations.of(context)!.translate("approve")!}",
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height:
                              1.4 * (MediaQuery.of(context).size.height / 25),
                          width: 5 * (MediaQuery.of(context).size.width / 15),
                          margin: EdgeInsets.only(bottom: 5, top: 5),
                          child: RaisedButton(
                            elevation: 5.0,
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () {
                              overtimeBloc.add(UpdateOvertimeStatusStarted(
                                  id: overtime.id,
                                  status: "rejected",
                                  paytype: _payTypeCtrl.text));
                            },
                            child: Text(
                              "${AppLocalizations.of(context)!.translate("reject")!}",
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  // ? Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       CupertinoButton(
                  //           padding: EdgeInsets.all(1.0),
                  //           color: Colors.green,
                  //           child: Row(
                  //             children: [
                  //               Icon(Icons.edit),
                  //             ],
                  //           ),
                  //           onPressed: () {
                  //             _displayTextInputDialog(context, overtime.id);
                  //           }),
                  //       SizedBox(
                  //         width: 5,
                  //       ),
                  //       CupertinoButton(
                  //           padding: EdgeInsets.all(1.0),
                  //           color: Colors.red,
                  //           child: Row(
                  //             children: [
                  //               Icon(Icons.delete),
                  //             ],
                  //           ),
                  //           onPressed: () {
                  //             deleteDialog(
                  //                 context: context,
                  //                 onPress: () {
                  //                   print("id ${overtime.id}");
                  //                   overtimeBloc.add(
                  //                       DeleteOvertimeStarted(id: overtime.id));
                  //                   Navigator.pop(context);
                  //                 });
                  //           }),
                  //     ],
                  //   )
                  : overtime.status == "rejected"
                      ? Container()
                      : Container(),
            ],
          ),
          builder: (_, collapsed, expanded) {
            return Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Expandable(
                collapsed: collapsed,
                expanded: expanded,
                theme: const ExpandableThemeData(crossFadePoint: 0),
              ),
            );
          },
        ));
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
            overtimeBloc.add(InitailzeMyOvertimeStarted(
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

  Future<void> _displayTextInputDialog(BuildContext context, String id) async {
    return showDialog(
        context: context,
        builder: (context) {
          return BlocListener(
            bloc: overtimeBloc,
            listener: (context, state) {
              if (state is AddingOvertime) {
                EasyLoading.show(status: 'loading...');
              }
              if (state is ErrorAddingOvertime) {
                EasyLoading.dismiss();
                errorSnackBar(text: state.error.toString(), context: context);
              }
              if (state is AddedOvertime) {
                EasyLoading.dismiss();
                EasyLoading.showSuccess('Success');
                Navigator.pop(context);
                print("success");
              }
            },
            child: AlertDialog(
              title: Text('Choose Paytype'),
              content: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _payTypeCtrl,

                    readOnly: true,
                    onTap: () {
                      customModal(context, _payType, (value) {
                        _payTypeCtrl.text = value;
                      });
                    },
                    // keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.arrow_drop_down),
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          borderSide: new BorderSide(
                            width: 1,
                          ),
                        ),
                        isDense: true,
                        labelText: "Choose pay type"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'type is required.';
                      }
                      return null;
                    },
                  )),
              actions: <Widget>[
                FlatButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                    _textFieldController.clear();
                    _payTypeCtrl.clear();
                  },
                ),
                FlatButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text('OK'),
                  onPressed: () {
                    if (_formKey!.currentState!.validate()) {
                      print(_payTypeCtrl.text);
                      overtimeBloc.add(UpdateOvertimeStatusStarted(
                          id: id,
                          status: "approved",
                          paytype: _payTypeCtrl.text));
                    }
                  },
                ),
              ],
            ),
          );
        });
  }
}
