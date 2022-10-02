import 'package:e_learning/src/feature/account/screen/widget/menu_detail.dart';
import 'package:e_learning/src/feature/employee/bloc/index.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../appLocalizations.dart';

class ProfileTeamDetail extends StatefulWidget {
  final String id;
  final String name;
  const ProfileTeamDetail({required this.id, required this.name});

  @override
  State<ProfileTeamDetail> createState() => _ProfileTeamDetailState();
}

class _ProfileTeamDetailState extends State<ProfileTeamDetail> {
  EmployeeBloc _employeeBloc = EmployeeBloc();
  @override
  void initState() {
    _employeeBloc.add(FetchEmployeeDetailStarted(id: widget.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(context, "${widget.name}"),
      body: BlocBuilder(
          bloc: _employeeBloc,
          builder: (context, state) {
            if (state is ErrorFetchingEmployee) {
              return Center(
                child: TextButton(
                    onPressed: () {
                      _employeeBloc
                          .add(FetchEmployeeDetailStarted(id: widget.id!));
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.teal,
                      onSurface: Colors.grey,
                    ),
                    child: Text("Retry")),
              );
            }
            if (state is FetchedEmployee) {
              return Stack(
                children: [
                  Container(
                    height: 70,
                    width: double.infinity,
                    color: Theme.of(context).primaryColor,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          // custom detail tile
                          menuItemTile(
                            onPressed: () {},
                            overidingWidget: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        "${AppLocalizations.of(context)!.translate("name")!} : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    Expanded(
                                      child: Text(
                                        _employeeBloc.accountModel!.name!,
                                        textScaleFactor: 1.1,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                        "${AppLocalizations.of(context)!.translate("cardNumber")!} : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    _employeeBloc.accountModel!.card == null
                                        ? Text("")
                                        : Expanded(
                                            child: Text(
                                              _employeeBloc.accountModel!.card!,
                                              textScaleFactor: 1.1,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                        "${AppLocalizations.of(context)!.translate("dob")!} : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    _employeeBloc.accountModel!.dob == null
                                        ? Text("")
                                        : Expanded(
                                            child: Text(
                                              _employeeBloc.accountModel!.dob!,
                                              textScaleFactor: 1.1,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                        "${AppLocalizations.of(context)!.translate("nationality")!} : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    _employeeBloc.accountModel!.nationalilty ==
                                            null
                                        ? Text("")
                                        : Expanded(
                                            child: Text(
                                              _employeeBloc
                                                  .accountModel!.nationalilty!,
                                              textScaleFactor: 1.1,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                // Row(
                                //   children: [
                                //     Text("Address : ",
                                //         style: Theme.of(context).textTheme.bodyText1),
                                //     widget.accountModel.address == null
                                //         ? Text("")
                                //         : Expanded(
                                //             child: Text(
                                //               widget.accountModel.address!,
                                //               textScaleFactor: 1.1,
                                //               style: TextStyle(
                                //                   color: Colors.black,
                                //                   fontWeight: FontWeight.bold),
                                //             ),
                                //           ),
                                //   ],
                                // ),
                                Row(
                                  children: [
                                    Text(
                                      "${AppLocalizations.of(context)!.translate("phone")!} : ",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    _employeeBloc.accountModel!.phone == null
                                        ? Text("")
                                        : Expanded(
                                            child: Text(
                                              _employeeBloc.accountModel!.phone!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                  ],
                                ),
                                SizedBox(height: 5),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${AppLocalizations.of(context)!.translate("email")!} : ",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    _employeeBloc.accountModel!.email == null
                                        ? Text("")
                                        : Expanded(
                                            child: Text(
                                              "${_employeeBloc.accountModel!.email}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                _employeeBloc.accountModel!.maritalStatus ==
                                        null
                                    ? Container()
                                    : Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context)!.translate("merital_status")!} : ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          _employeeBloc.accountModel!
                                                      .maritalStatus ==
                                                  null
                                              ? Container()
                                              : Expanded(
                                                  child: Text(
                                                    "${_employeeBloc.accountModel!.maritalStatus}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  ),
                                                ),
                                        ],
                                      ),
                                SizedBox(height: 5),
                                _employeeBloc.accountModel!.minorChild == null
                                    ? Container()
                                    : Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context)!.translate("minor_children")!} : ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          _employeeBloc.accountModel!
                                                      .minorChild ==
                                                  null
                                              ? Container()
                                              : Expanded(
                                                  child: Text(
                                                    "${_employeeBloc.accountModel!.minorChild}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  ),
                                                ),
                                        ],
                                      ),
                                SizedBox(height: 5),
                                _employeeBloc.accountModel!.spouseJob == null
                                    ? Container()
                                    : Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context)!.translate("sponse_job")!} : ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          _employeeBloc.accountModel!
                                                      .spouseJob ==
                                                  null
                                              ? Container()
                                              : Expanded(
                                                  child: Text(
                                                    "${_employeeBloc.accountModel!.spouseJob}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  ),
                                                ),
                                        ],
                                      ),
                              ],
                            ),
                            iconBackgroundColor: Colors.white,
                            iconPath: '',
                            title: '',
                          ),
                          SizedBox(height: 10),
                          menuItemTile(
                            onPressed: () {},
                            overidingWidget: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${AppLocalizations.of(context)!.translate("position")!} : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.orange[800]),
                                      ),
                                      Text(
                                        _employeeBloc.accountModel!
                                            .positionModel!.positionName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.orange[800]),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${AppLocalizations.of(context)!.translate("department")!} : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(),
                                      ),
                                      Text(
                                        _employeeBloc.accountModel!
                                            .departmentModel!.departmentName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.purple),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${AppLocalizations.of(context)!.translate("office_tel")!}  : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    _employeeBloc.accountModel!.officeTel ==
                                            null
                                        ? Text("")
                                        : Expanded(
                                            child: Text(
                                              _employeeBloc.accountModel!.officeTel!,
                                              textScaleFactor: 1.1,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                _employeeBloc.accountModel!.email == null
                                    ? Container()
                                    : Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context)!.translate("address")!} : ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          _employeeBloc.accountModel!.address ==
                                                  null
                                              ? Container()
                                              : Expanded(
                                                  child: Text(
                                                    "${_employeeBloc.accountModel!.address}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  ),
                                                ),
                                        ],
                                      ),
                                SizedBox(height: 5),
                              ],
                            ),
                            iconBackgroundColor: Colors.white,
                            iconPath: '',
                            title: '',
                          ),
                          SizedBox(height: 10),

                          menuItemTile(
                            onPressed: () {},
                            overidingWidget: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${AppLocalizations.of(context)!.translate("timetable")!}"),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${AppLocalizations.of(context)!.translate("time_in")!} : ",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${_employeeBloc.accountModel!.timetableModel!.onDutyTtime}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${AppLocalizations.of(context)!.translate("time_out")!} : ",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${_employeeBloc.accountModel!.timetableModel!.offDutyTime}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ],
                                ),
                                // Container(
                                //   height: 50,
                                //   child: time(context,
                                //       time: widget.accountModel.timetableModel!),
                                // ),
                                SizedBox(height: 5),
                              ],
                            ),
                            iconBackgroundColor: Colors.white,
                            iconPath: '',
                            title: '',
                          ),
                          SizedBox(height: 10),

                          menuItemTile(
                            onPressed: () {},
                            overidingWidget: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${AppLocalizations.of(context)!.translate("workday")!}"),

                                // Container(
                                //   height: 50,
                                //   child: time(context,
                                //       time: widget.accountModel.timetableModel!),
                                // ),
                                SizedBox(height: 5),
                              ],
                            ),
                            iconBackgroundColor: Colors.white,
                            iconPath: '',
                            title: '',
                          ),
                          SizedBox(height: 10),

                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: Lottie.asset('assets/animation/loader.json',
                  width: 200, height: 200),
            );
          }),
    );
  }
}
