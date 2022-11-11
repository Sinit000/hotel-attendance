import 'package:e_learning/src/feature/leaveout/bloc/index.dart';
import 'package:e_learning/src/feature/leaveout/model/leaveout_model.dart';
import 'package:e_learning/src/shared/widget/custome_modal.dart';
import 'package:e_learning/src/shared/widget/error_snackbar.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import '../../../../appLocalizations.dart';

class EditLeaveOut extends StatefulWidget {
  final LeaveOutModel leaveOutModel;
  const EditLeaveOut({required this.leaveOutModel});

  @override
  State<EditLeaveOut> createState() => _EditLeaveOutState();
}

class _EditLeaveOutState extends State<EditLeaveOut> {
  final TextEditingController _leaveCtrl = TextEditingController();
  final TextEditingController _timeInCtrl = TextEditingController();
  final TextEditingController _timeOutCtrl = TextEditingController();
  final TextEditingController _reasonCtrl = TextEditingController();
  final TextEditingController _numCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();

  final TextEditingController _typeCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();

  DateTime? date;
  DateTime dateNow = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String? dateToday;
  String? createDate;
  List<String> typeList = ['leave_out', 'clear_leave_out'];
  List<String> reasonList = ['work', 'personal'];
  String select = "";
  bool isSeclect = false;
  @override
  void initState() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MM/dd/yyyy').format(now);
    String creDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
    createDate = creDate.toString();
    dateToday = formattedDate.toString();
    _reasonCtrl.text = widget.leaveOutModel.reason!;
    _timeInCtrl.text = widget.leaveOutModel.timein!;
    _timeOutCtrl.text = widget.leaveOutModel.timeout!;
    _typeCtrl.text = widget.leaveOutModel.requestType!;
    _numCtrl.text = widget.leaveOutModel.duration!;
    widget.leaveOutModel.note == null || widget.leaveOutModel.note == "null"
        ? _noteCtrl.text = ""
        : _noteCtrl.text = widget.leaveOutModel.note!;

    // if (widget.leaveOutModel.note != null ||
    //     widget.leaveOutModel.note != "null") {
    //   _noteCtrl.text = widget.leaveOutModel.note!;
    // } else {
    //   _noteCtrl.text = "";
    // }
    super.initState();
  }

  _dialogTime({required TextEditingController controller}) async {
    showTimePicker(
      context: context,
      initialTime: selectedTime,
    ).then((value) {
      print(value);
      if (value == null) {
        print("no selt");
      } else {
        setState(() {
          selectedTime = value;
          DateTime parsedTime =
              DateFormat.jm().parse(selectedTime.format(context).toString());
          final String time = DateFormat('HH:mm:ss').format(parsedTime);
          print("out put time $time");

          controller.text = time;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context,
          "${AppLocalizations.of(context)!.translate("edit_leaveout")!}"),
      body: Builder(builder: (context) {
        return BlocListener(
          bloc: BlocProvider.of<LeaveOutBloc>(context),
          listener: (context, state) {
            if (state is AddingLeaveOut) {
              EasyLoading.show(status: 'loading...');
            }
            if (state is ErrorAddingLeaveOut) {
              EasyLoading.dismiss();
              errorSnackBar(text: state.error.toString(), context: context);
            }
            if (state is AddedLeaveOut) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Success');
              Navigator.pop(context);
              print("success");
            }
          },
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _typeCtrl,
                        onTap: () {
                          customModal(context, typeList, (value) {
                            _typeCtrl.text = value;
                            select = value;

                            setState(() {
                              isSeclect = true;
                            });
                            print(select);
                            print(value);
                          });
                        },

                        readOnly: true,
                        // keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.grey.shade400)),
                            enabledBorder: InputBorder.none,
                            // isDense: true,
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                            ),
                            labelText:
                                "${AppLocalizations.of(context)!.translate("type")!}"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'type  is required.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      isSeclect == true && select == "leave_out"
                          ? TextFormField(
                              controller: _reasonCtrl,
                              keyboardType: TextInputType.text,
                              // maxLines: null,
                              onTap: () {
                                customModal(context, reasonList, (value) {
                                  _reasonCtrl.text = value;
                                  print(value);
                                });
                              },

                              readOnly: true,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.grey.shade400)),
                                  enabledBorder: InputBorder.none,
                                  // isDense: true,
                                  contentPadding: const EdgeInsets.only(
                                    left: 14.0,
                                  ),
                                  labelText:
                                      "${AppLocalizations.of(context)!.translate("reason")!}"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Reason is required';
                                }
                                return null;
                              },
                            )
                          : TextFormField(
                              controller: _reasonCtrl,
                              keyboardType: TextInputType.text,
                              maxLines: null,
                              decoration: InputDecoration(
                                  // suffixIcon: Icon(Icons.arrow_drop_down),
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.grey.shade400)),
                                  enabledBorder: InputBorder.none,
                                  // isDense: true,
                                  contentPadding: const EdgeInsets.only(
                                    left: 14.0,
                                  ),
                                  labelText:
                                      "${AppLocalizations.of(context)!.translate("reason")!}"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Reason is required';
                                }
                                return null;
                              },
                            ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _timeOutCtrl,
                        // keyboardType: TextInputType.text,
                        readOnly: true,
                        onTap: () {
                          _dialogTime(controller: _timeOutCtrl);
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.date_range_outlined,
                              color: Colors.lightBlue,
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.grey.shade400)),
                            enabledBorder: InputBorder.none,
                            // isDense: true,
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                            ),
                            labelText:
                                "${AppLocalizations.of(context)!.translate("time_out")!}"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Time out is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _timeInCtrl,
                        readOnly: true,
                        // keyboardType: TextInputType.text,
                        onTap: () {
                          _dialogTime(controller: _timeInCtrl);
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.date_range_outlined,
                              color: Colors.lightBlue,
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.grey.shade400)),
                            enabledBorder: InputBorder.none,
                            // isDense: true,
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                            ),
                            labelText:
                                "${AppLocalizations.of(context)!.translate("time_in")!}"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Time in is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _noteCtrl,
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.grey.shade400)),
                            enabledBorder: InputBorder.none,
                            // isDense: true,
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                            ),
                            labelText:
                                "${AppLocalizations.of(context)!.translate("notes")!}"),
                      ),
                      SizedBox(height: 15),
                      SizedBox(height: MediaQuery.of(context).size.height / 10),
                      Container(
                        margin:
                            EdgeInsets.only(left: 30, right: 30, bottom: 10),
                        height: 50,
                        width: double.infinity,
                        child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              // side: BorderSide(color: Colors.red)
                            ),
                            color: Colors.blue,
                            onPressed: () {
                              if (_formKey!.currentState!.validate()) {
                                // addessdetail = 11.565271/94.6778 so we need to spilt into lat and long
                                BlocProvider.of<LeaveOutBloc>(context).add(
                                    UpdateLeaveOutStarted(
                                        requestType: _typeCtrl.text,
                                        id: widget.leaveOutModel.id,
                                        createdDate: createDate!,
                                        today: dateToday!,
                                        reason: _reasonCtrl.text,
                                        timein: _timeInCtrl.text,
                                        note: _noteCtrl.text,
                                        timeout: _timeOutCtrl.text));
                              }
                            },
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "${AppLocalizations.of(context)!.translate("submit")!}",
                              // AppLocalizations.of(context)!.translate("submit")!,
                              textScaleFactor: 1.2,
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
