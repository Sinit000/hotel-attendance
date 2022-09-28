import 'package:e_learning/src/feature/account/model/account_model.dart';
import 'package:e_learning/src/feature/employee/bloc/employee_bloc.dart';
import 'package:e_learning/src/feature/employee/bloc/index.dart';
import 'package:e_learning/src/feature/employee/model/employee_model.dart';
import 'package:e_learning/src/feature/overtime/bloc/index.dart';
import 'package:e_learning/src/feature/overtime/screen/overtime_page.dart';
import 'package:e_learning/src/shared/widget/custome_modal.dart';
import 'package:e_learning/src/shared/widget/error_snackbar.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import '../../../../appLocalizations.dart';

class AddOvertime extends StatefulWidget {
  const AddOvertime({Key? key}) : super(key: key);

  @override
  State<AddOvertime> createState() => _AddOvertimeState();
}

class _AddOvertimeState extends State<AddOvertime> {
  final TextEditingController _usrCtrl = TextEditingController();
  final TextEditingController _fromCtrl = TextEditingController();
  final TextEditingController _toCtrl = TextEditingController();
  final TextEditingController _reasonCtrl = TextEditingController();
  final TextEditingController _numCtrl = TextEditingController();
  final TextEditingController? _subtypeCtrl = TextEditingController();
  final TextEditingController _typeCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  final TextEditingController _otMethodCtrl = TextEditingController();

  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  EmployeeBloc _employeeBloc = EmployeeBloc();
  DateTime? date;
  DateTime dateNow = DateTime.now();
  String? dateToday;
  String id = "";
  String? createDate;
  // String? mydate;

  List<String> typeList = [
    'hour',
    'day',
  ];
  @override
  void initState() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MM/dd/yyyy').format(now);
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

          String formateDate = DateFormat('MM/dd/yyyy').format(date!);

          controller.text = formateDate.toString();
        });
      }
      // after click on date ,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(
          context, "${AppLocalizations.of(context)!.translate("add_ot")!}"),
      body: Builder(builder: (context) {
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
          child: BlocListener(
              bloc: _employeeBloc,
              listener: (context, state) {
                if (state is FetchingEmployee) {
                  EasyLoading.show(status: 'loading');
                }
                if (state is ErrorFetchingEmployee) {
                  EasyLoading.dismiss();
                  errorSnackBar(text: state.error.toString(), context: context);
                }
                if (state is FetchedEmployee) {
                  EasyLoading.dismiss();

                  customModal(context,
                      _employeeBloc.emploList.map((e) => e.name!).toList(),
                      (value) {
                    _usrCtrl.text = value;
                  });
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
                          SizedBox(height: 15),
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
                            controller: _usrCtrl,
                            onTap: () {
                              _employeeBloc
                                  .add(FetchAllEmployeeByDepartmentStarted());
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
                                    "${AppLocalizations.of(context)!.translate("choose_username")!}"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'user name is required.';
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
                            controller: _otMethodCtrl,
                            keyboardType: TextInputType.text,
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
                                    "${AppLocalizations.of(context)!.translate("otMethod")!}"),
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
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 10),
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

                                    AccountModel user = _employeeBloc.emploList
                                        .firstWhere((element) =>
                                            element.name == _usrCtrl.text);

                                    overtimeBloc.add(AddOvertimeStarted(
                                        type: _typeCtrl.text,
                                        userId: user.id!,
                                        fromDate: _fromCtrl.text,
                                        toDate: _toCtrl.text,
                                        notes: _noteCtrl.text,
                                        reason: _reasonCtrl.text,
                                        otMethod: _otMethodCtrl.text,
                                        createdDate: createDate!,
                                        today: dateToday!,
                                        duration: _numCtrl.text));
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
              )),
        );
      }),
    );
  }

  // void _showPicker(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return SafeArea(
  //           child: Container(
  //             child: new Wrap(
  //               children: <Widget>[
  //                 new ListTile(
  //                     leading: new Icon(Icons.photo_library),
  //                     title: new Text('Photo Library'),
  //                     onTap: () {
  //                       // _imgFromGallery();
  //                       Helper.imgFromGallery((image) {
  //                         setState(() {
  //                           _image = image;
  //                         });
  //                       });
  //                       Navigator.of(context).pop();
  //                     }),
  //                 new ListTile(
  //                   leading: new Icon(Icons.photo_camera),
  //                   title: new Text('Camera'),
  //                   onTap: () {
  //                     Helper.imgFromCamera((image) {
  //                       setState(() {
  //                         _image = image;
  //                       });
  //                     });
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
}
