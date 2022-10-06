import 'dart:io';

import 'package:e_learning/src/feature/permission/bloc/index.dart';
import 'package:e_learning/src/feature/permission/model/leave_model.dart';
import 'package:e_learning/src/feature/permission/model/leave_type_model.dart';
import 'package:e_learning/src/feature/permission/screen/leave_page.dart';
import 'package:e_learning/src/feature/subtype/bloc/index.dart';
import 'package:e_learning/src/feature/subtype/model/subtype_model.dart';
import 'package:e_learning/src/shared/widget/custome_modal.dart';
import 'package:e_learning/src/shared/widget/error_snackbar.dart';
import 'package:e_learning/src/shared/widget/loadin_dialog.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:e_learning/src/utils/share/helper.dart';
// import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import '../../../../appLocalizations.dart';
// import 'package:elegant_notification/elegant_notification.dart';

class EditLeave extends StatefulWidget {
  final String parent;
  final LeaveModel leaveModel;
  const EditLeave({required this.leaveModel, required this.parent});

  @override
  State<EditLeave> createState() => _EditLeaveState();
}

class _EditLeaveState extends State<EditLeave> {
  final TextEditingController _leaveCtrl = TextEditingController();
  final TextEditingController _fromCtrl = TextEditingController();
  final TextEditingController _toCtrl = TextEditingController();
  final TextEditingController _reasonCtrl = TextEditingController();
  final TextEditingController _numCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  final TextEditingController? _subtypeCtrl = TextEditingController();
  final TextEditingController _typeCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  LeaveTypeModel? leaveTypeModel;
  SubtypeBloc _subtypeBloc = SubtypeBloc();
  // SubtypeModel? subtypeModel;
  bool isEnable = false;
  DateTime? date;
  DateTime dateNow = DateTime.now();
  String? dateToday;
  String? createDate;
  File? _image;
  List<String> typeList = ['hour', 'half_day_m', 'half_day_n', 'day'];
  @override
  void initState() {
    _typeCtrl.text = widget.leaveModel.type!;
    _fromCtrl.text = widget.leaveModel.fromDate!;
    _toCtrl.text = widget.leaveModel.toDate!;
    _reasonCtrl.text = widget.leaveModel.reason!;
    _numCtrl.text = widget.leaveModel.number!;
    if (widget.parent == "") {
      _leaveCtrl.text = widget.leaveModel.leaveTypeModel!.leaveType;
    } else {
      _leaveCtrl.text = widget.parent;
      _subtypeCtrl!.text = widget.leaveModel.leaveTypeModel!.leaveType;
    }
    // if (widget.leaveModel.leaveTypeModel!.parentId == "0") {
    //   _leaveCtrl.text = widget.leaveModel.leaveTypeModel!.leaveType;
    // } else {
    //   _leaveCtrl.text = widget.leaveModel.leaveTypeModel!.leaveType;
    //   _subtypeCtrl!.text = widget.leaveModel.leaveTypeModel!.leaveType;
    // }

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MM/dd/yyyy kk:mm:ss').format(now);
    String creDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
    createDate = creDate.toString();
    dateToday = formattedDate.toString();

    super.initState();
  }

  _dialogDate({required TextEditingController controller}) async {
    return showDatePicker(
      context: context,
      initialDate: dateNow,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 60),
    ).then((value) {
      if (value == null) {
        print("null");
      } else {
        setState(() {
          date = value;
          String formateDate = DateFormat('yyyy/MM/dd').format(date!);
          controller.text = formateDate.toString();
        });
      }
      // after click on date ,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: standardAppBar(
          context, "${AppLocalizations.of(context)!.translate("edit_leave")!}"),
      body: Builder(builder: (context) {
        return BlocListener(
          bloc: leaveBloc,
          listener: (context, state) {
            if (state is AddingLeave) {
              EasyLoading.show(status: 'loading...');
            }
            if (state is ErrorAddingLeave) {
              EasyLoading.dismiss();
              errorSnackBar(text: state.error.toString(), context: context);
            }
            if (state is AddedLeave) {
              EasyLoading.dismiss();
              EasyLoading.showToast("Success");

              Navigator.pop(context);
              print("success");
            }
          },
          child: BlocListener(
              bloc: leaveBloc,
              listener: (context, state) {
                if (state is FetchingLeaveType) {
                  EasyLoading.show(status: 'loading...');
                }
                if (state is ErrorFetchingLeaveType) {
                  EasyLoading.dismiss();
                  errorSnackBar(text: state.error.toString(), context: context);
                }
                if (state is FetchedLeaveType) {
                  EasyLoading.dismiss();
                  customModal(context,
                      leaveBloc.leaveList.map((e) => e.leaveType).toList(),
                      (value) {
                    _leaveCtrl.text = value;
                    leaveTypeModel = leaveBloc.leaveList
                        .firstWhere((e) => e.leaveType == value);
                    // user choose again(change must clear subtype contrller)
                    _subtypeCtrl!.clear();
                  });
                }
              },
              child: BlocListener(
                bloc: _subtypeBloc,
                listener: (context, state) {
                  if (state is FetchingSubtype) {
                    EasyLoading.show(status: 'loading...');
                  }
                  if (state is ErrorFetchingLeaveType) {
                    EasyLoading.dismiss();
                    errorSnackBar(
                        text: state.error.toString(), context: context);
                  }
                  if (state is FetchedSubtype) {
                    EasyLoading.dismiss();
                    if (state.length == 0) {
                      _subtypeCtrl!.text = "No data";
                    } else {
                      customModal(context,
                          _subtypeBloc.subtype.map((e) => e.leaveType).toList(),
                          (value) {
                        _subtypeCtrl!.text = value;
                        // leaveTypeModel = _subtypeBloc.subtype
                        //     .firstWhere((e) => e.leaveType == _subtypeCtrl!.text);
                        // _numCtrl.text = subtypeModel!.duration;
                      });
                    }
                  }
                },
                child: ListView(
                  children: [
                    Form(
                      key: _formKey,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _typeCtrl,
                              onTap: () {
                                customModal(context, typeList, (value) {
                                  _typeCtrl.text = value;
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
                            TextFormField(
                              controller: _leaveCtrl,
                              onTap: () {
                                leaveBloc.add(FetchLeaveTypeStarted());
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
                                      "${AppLocalizations.of(context)!.translate("leave_type")!}"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Leave Type is required.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _subtypeCtrl,
                              // enabled: isEnable,
                              onTap: () {
                                print(
                                    widget.leaveModel.leaveTypeModel!.parentId);
                                if (_leaveCtrl.text == widget.parent) {
                                  _subtypeBloc.add(FetchSubtypeStarted(
                                      id: widget.leaveModel.leaveTypeModel!
                                          .parentId));
                                } else {
                                  _subtypeBloc.add(FetchSubtypeStarted(
                                      id: widget.leaveModel.leaveTypeModel!.id
                                          .toString()));
                                }
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
                                      "${AppLocalizations.of(context)!.translate("subtype")!}"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Subtype Type is required.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _reasonCtrl,
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
                              controller: _numCtrl,
                              keyboardType: TextInputType.number,
                              // keyboardType: TextInputType.multiline,
                              // minLines: 5,
                              // maxLines: 20,
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
                                      "${AppLocalizations.of(context)!.translate("duration")!}"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Duration is required.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _fromCtrl,
                              readOnly: true,
                              // keyboardType: TextInputType.text,
                              onTap: () {
                                _dialogDate(controller: _fromCtrl);
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
                                      "${AppLocalizations.of(context)!.translate("from_date")!}"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'From date is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _toCtrl,
                              // keyboardType: TextInputType.text,
                              readOnly: true,
                              onTap: () {
                                _dialogDate(controller: _toCtrl);
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
                                      "${AppLocalizations.of(context)!.translate("to_date")!}"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'To Date is required';
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
                            GestureDetector(
                                onTap: () {
                                  _showPicker(context);
                                },
                                child: Container(
                                    width: (MediaQuery.of(context).size.width /
                                            10) *
                                        8,
                                    child: (_image == null)
                                        ? widget.leaveModel.imgUrl == null
                                            ? Container(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        10) *
                                                    4,
                                                height: (MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        10) *
                                                    4,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: FittedBox(
                                                  fit: BoxFit.fill,
                                                  child: Icon(
                                                    Icons.add_a_photo_outlined,
                                                    color: Colors.grey[600],
                                                    size:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                10) *
                                                            3,
                                                  ),
                                                ),
                                              )
                                            : FadeInImage.assetNetwork(
                                                placeholder:
                                                    "assets/animation/loader.json",
                                                image:
                                                    "https://banban-hr.herokuapp.com/${widget.leaveModel.imgUrl!}",
                                                fit: BoxFit.fill,
                                                imageErrorBuilder: (context,
                                                    error, StackTrace) {
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 20),
                                                    width:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                10) *
                                                            4,
                                                    height:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                10) *
                                                            4,
                                                    child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Icon(
                                                        Icons
                                                            .add_a_photo_outlined,
                                                        color: Colors.grey[600],
                                                        size: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                10) *
                                                            3,
                                                      ),
                                                    ),
                                                  );
                                                })
                                        : Container(
                                            // height: MediaQuery.of(context).size.width / 3,
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    10) *
                                                7,
                                            child: Image.file(_image!)))),
                            SizedBox(
                                height: MediaQuery.of(context).size.height / 4),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 30, right: 30, bottom: 10),
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
                                      String leaveId = "";
                                      String url = "";
                                      String _subtype = "";
                                      // print("hi");
                                      // check if subtype no data or not
                                      if (_subtypeCtrl!.text == "No data") {
                                        if (_leaveCtrl.text ==
                                            widget.leaveModel.leaveTypeModel!
                                                .leaveType) {
                                          leaveId = widget
                                              .leaveModel.leaveTypeModel!.id;
                                        } else {
                                          LeaveTypeModel select = leaveBloc
                                              .leaveList
                                              .firstWhere((element) =>
                                                  element.leaveType ==
                                                  _leaveCtrl.text);
                                          leaveId = select.id;
                                        }
                                      } else {
                                        print(widget.leaveModel.type);
                                        print(_subtypeCtrl!.text);
                                        if (_subtypeCtrl!.text !=
                                            widget.leaveModel.leaveTypeModel!
                                                .leaveType) {
                                          LeaveTypeModel select = _subtypeBloc
                                              .subtype
                                              .firstWhere((element) =>
                                                  element.leaveType ==
                                                  _subtypeCtrl!.text);
                                          leaveId = select.id;
                                        } else {
                                          leaveId = widget
                                              .leaveModel.leaveTypeModel!.id;
                                        }
                                      }

                                      // if (_leaveCtrl.text !=
                                      //     widget.leaveModel.leaveTypeModel!
                                      //         .leaveType) {
                                      //   LeaveTypeModel select = leaveBloc
                                      //       .leaveList
                                      //       .firstWhere((element) =>
                                      //           element.leaveType ==
                                      //           _leaveCtrl.text);
                                      //   leaveId = select.id;
                                      // } else {
                                      //   leaveId = widget
                                      //       .leaveModel.leaveTypeModel!.id;
                                      // }
                                      if (widget.leaveModel.imgUrl == null) {
                                        url = "";
                                      } else {
                                        url = widget.leaveModel.imgUrl!;
                                      }
                                      print(leaveId);
                                      leaveBloc.add(UpdateLeaveStarted(
                                        createdDate: createDate!,
                                        today: dateToday!,
                                        notes: _noteCtrl.text,
                                        type: _typeCtrl.text,
                                        // subtype: _subtypeCtrl!.text,
                                        imageUrl: url,
                                        imgUrl: _image,
                                        id: widget.leaveModel.id,
                                        leaveTypeId: leaveId,
                                        reason: _reasonCtrl.text,
                                        number: _numCtrl.text,
                                        fromDate: _fromCtrl.text,
                                        toDate: _toCtrl.text,
                                        // date: dateToday
                                      ));
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
              )),
        );
      }),
      // bottomNavigationBar: Container(
      //   margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      //   height: 50,
      //   width: double.infinity,
      //   child: FlatButton(
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(20),
      //         // side: BorderSide(color: Colors.red)
      //       ),
      //       color: Colors.blue,
      //       onPressed: () {
      //         if (_formKey!.currentState!.validate()) {
      //           // addessdetail = 11.565271/94.6778 so we need to spilt into lat and long

      //           // print("hi");

      //           LeaveTypeModel select = BlocProvider.of<LeaveBloc>(context)
      //               .leaveList
      //               .firstWhere(
      //                   (element) => element.leaveType == _leaveCtrl.text);

      //           BlocProvider.of<LeaveBloc>(context).add(UpdateLeaveStarted(
      //             // employeeId: widget.id,
      //             id: widget.leaveModel.id,
      //             leaveTypeId: select.id,
      //             reason: _reasonCtrl.text,
      //             number: _numCtrl.text,
      //             fromDate: _fromCtrl.text,
      //             toDate: _toCtrl.text,
      //             // date: dateToday
      //           ));
      //         }
      //       },
      //       padding: EdgeInsets.symmetric(vertical: 10),
      //       child: Text(
      //         "Submit",
      //         // AppLocalizations.of(context)!.translate("submit")!,
      //         textScaleFactor: 1.2,
      //         style: TextStyle(color: Colors.white),
      //       )),
      // ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        // _imgFromGallery();
                        Helper.imgFromGallery((image) {
                          setState(() {
                            _image = image;
                          });
                        });
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      Helper.imgFromCamera((image) {
                        setState(() {
                          _image = image;
                        });
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
