import 'package:e_learning/src/feature/account/bloc/index.dart';
import 'package:e_learning/src/feature/account/model/account_model.dart';
import 'package:e_learning/src/feature/account/screen/account_page_one.dart';
import 'package:e_learning/src/feature/account/screen/edit_profile.dart';
import 'package:e_learning/src/feature/account/screen/widget/menu_detail.dart';
import 'package:e_learning/src/feature/account/screen/widget/workday.dart';

import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../appLocalizations.dart';

class UserInfoDetail extends StatefulWidget {
  final AccountModel? accountModel;

  const UserInfoDetail({
    required this.accountModel,
  });

  @override
  State<UserInfoDetail> createState() => _UserInfoDetailState();
}

class _UserInfoDetailState extends State<UserInfoDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(
          context, "${AppLocalizations.of(context)!.translate("my_info")!}"),
      body: Stack(
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
                                style: Theme.of(context).textTheme.bodyText1),
                            Expanded(
                              child: Text(
                                widget.accountModel!.name!,
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
                                style: Theme.of(context).textTheme.bodyText1),
                            widget.accountModel!.card == null ||
                                    widget.accountModel!.card == "null"
                                ? Text("")
                                : Expanded(
                                    child: Text(
                                      widget.accountModel!.card!,
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
                                style: Theme.of(context).textTheme.bodyText1),
                            widget.accountModel!.dob == null ||
                                    widget.accountModel!.dob == "null"
                                ? Text("")
                                : Expanded(
                                    child: Text(
                                      widget.accountModel!.dob!,
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
                                style: Theme.of(context).textTheme.bodyText1),
                            widget.accountModel!.nationalilty == null ||
                                    widget.accountModel!.nationalilty == "null"
                                ? Text("")
                                : Expanded(
                                    child: Text(
                                      widget.accountModel!.nationalilty!,
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
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            widget.accountModel!.phone == null ||
                                    widget.accountModel!.phone == "null"
                                ? Text("")
                                : Expanded(
                                    child: Text(
                                      widget.accountModel!.phone!,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
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
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            widget.accountModel!.email == null ||
                                    widget.accountModel!.email == "null"
                                ? Text("")
                                : Expanded(
                                    child: Text(
                                      "${widget.accountModel!.email}",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.translate("merital_status")!} : ",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            widget.accountModel!.maritalStatus == null ||
                                    widget.accountModel!.maritalStatus == "null"
                                ? Container()
                                : Expanded(
                                    child: Text(
                                      "${widget.accountModel!.maritalStatus}",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.translate("minor_children")!} : ",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            widget.accountModel!.minorChild == null ||
                                    widget.accountModel!.minorChild == "null"
                                ? Container()
                                : Expanded(
                                    child: Text(
                                      "${widget.accountModel!.minorChild}",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.translate("sponse_job")!} : ",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            widget.accountModel!.spouseJob == null ||
                                    widget.accountModel!.spouseJob == "null"
                                ? Container()
                                : Expanded(
                                    child: Text(
                                      "${widget.accountModel!.spouseJob}",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
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
                                    .copyWith(color: Colors.orange[800]),
                              ),
                              Text(
                                widget
                                    .accountModel!.positionModel!.positionName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.orange[800]),
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
                                widget.accountModel!.departmentModel!
                                    .departmentName,
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
                                style: Theme.of(context).textTheme.bodyText1),
                            widget.accountModel!.officeTel == null
                                ? Text("")
                                : Expanded(
                                    child: Text(
                                      widget.accountModel!.officeTel!,
                                      textScaleFactor: 1.1,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(height: 5),
                        widget.accountModel!.email == null
                            ? Container()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${AppLocalizations.of(context)!.translate("address")!} : ",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  widget.accountModel!.address == null
                                      ? Container()
                                      : Expanded(
                                          child: Text(
                                            "${widget.accountModel!.address}",
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
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Expanded(
                              child: Text(
                                "${widget.accountModel!.timetableModel!.onDutyTtime}",
                                style: Theme.of(context).textTheme.bodyText1,
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
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Expanded(
                              child: Text(
                                "${widget.accountModel!.timetableModel!.offDutyTime}",
                                style: Theme.of(context).textTheme.bodyText1,
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
                        Container(
                          height: MediaQuery.of(context).size.width / 3,
                          child: workday(context,
                              workday: widget.accountModel!.workModel!.workday),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                    iconBackgroundColor: Colors.white,
                    iconPath: '',
                    title: '',
                  ),
                  SizedBox(height: 10),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                            child: menuItemTile(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditProfile(
                                                accountModel:
                                                    accountBloc.accountModel!,
                                              )));
                                },
                                title:
                                    "${AppLocalizations.of(context)!.translate("editProfile")!}",
                                iconPath: "assets/icon/edit.png",
                                iconBackgroundColor: Colors.blue)),
                        SizedBox(
                          width: 10,
                        ),
                        // Expanded(
                        //     child: menuItemTile(
                        //         onPressed: () {
                        //           ;
                        //         },
                        //         title: AppLocalizations.of(context)!
                        //             .translate("saleHistory")!,
                        //         iconPath:
                        //             "assets/icons/customer_menu/history.png",
                        //         iconBackgroundColor: Colors.blue)),
                      ],
                    ),
                  ),

                  // SizedBox(height: 10),
                  // IntrinsicHeight(
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //           child: menuItemTile(
                  //               onPressed: () async {
                  //                 // await Navigator.push(
                  //                 //     context,
                  //                 //     MaterialPageRoute(
                  //                 //         builder: (c) => PosPage(
                  //                 //               customer: widget.customer,
                  //                 //             )));
                  //                 // BlocProvider.of<CustomerBloc>(context).add(
                  //                 //     FetchCustomerDetail(
                  //                 //         customerId: widget.customer.id!));
                  //               },
                  //               title: AppLocalizations.of(context)!
                  //                   .translate("sell")!,
                  //               iconPath: "assets/icons/customer_menu/sell.png",
                  //               iconBackgroundColor: Colors.green)),
                  //       // SizedBox(
                  //       //   width: space,
                  //       // ),

                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     style: buttonStyle,
                  //     onPressed: () {
                  //       Navigator.of(context).push(MaterialPageRoute(
                  //           builder: (c) => EditCustomerPage(
                  //                 customer: _customer,
                  //               )));
                  //     },
                  //     child: Text(
                  //       AppLocalizations.of(context)!.translate("editCus")!,
                  //       // style: TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 15),
                  // Container(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     style: buttonStyle.copyWith(
                  //         backgroundColor:
                  //             MaterialStateProperty.all<Color>(Colors.blue)),
                  //     onPressed: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (c) =>
                  //                   SaleReportPage(widget.customer)));
                  //     },
                  //     child: Text(
                  //       AppLocalizations.of(context)!.translate("saleHistory")!,
                  //       // style: TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 15),
                  // Container(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     style: buttonStyle.copyWith(
                  //         backgroundColor:
                  //             MaterialStateProperty.all<Color>(Colors.green)),
                  //     onPressed: () {
                  //       Cart cart = Cart();
                  //       cart.customer = widget.customer;
                  //       BlocProvider.of<CartBloc>(context)
                  //           .add(SetCart(cart: cart));
                  //       // BlocProvider.of<CartBloc>(context).cart.customer =
                  //       //     widget.customer;
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (c) => PosPage(
                  //                     customer: widget.customer,
                  //                   )));
                  //     },
                  //     child: Text(
                  //       AppLocalizations.of(context)!.translate("sell")!,
                  //       // style: TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
