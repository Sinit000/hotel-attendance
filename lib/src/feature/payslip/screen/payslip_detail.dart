import 'package:e_learning/src/feature/payslip/model/payslip_model.dart';
import 'package:e_learning/src/feature/payslip/screen/widget/menu_tile.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:flutter/material.dart';

import '../../../../appLocalizations.dart';

class PayslipDetail extends StatefulWidget {
  final PayslipModel payslipModel;
  const PayslipDetail({required this.payslipModel});

  @override
  State<PayslipDetail> createState() => _PayslipDetailState();
}

class _PayslipDetailState extends State<PayslipDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(context,
          "${AppLocalizations.of(context)!.translate("payslip_detail")!}"),
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
                                "${AppLocalizations.of(context)!.translate("base_salary")!} : ",
                                style: Theme.of(context).textTheme.bodyText1),
                            Expanded(
                              child: Text(
                                "\$${widget.payslipModel.baseSalary}",
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
                                "${AppLocalizations.of(context)!.translate("advance_salary")!} : ",
                                style: Theme.of(context).textTheme.bodyText1),
                            widget.payslipModel.advanceMoney == null
                                ? Text("")
                                : Expanded(
                                    child: Text(
                                      "\$${widget.payslipModel.advanceMoney}",
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
                                "${AppLocalizations.of(context)!.translate("bonus")!} : ",
                                style: Theme.of(context).textTheme.bodyText1),
                            widget.payslipModel.bonus == null
                                ? Text("")
                                : Expanded(
                                    child: Text(
                                      "\$${widget.payslipModel.bonus}",
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
                        //     Text(
                        //         "${AppLocalizations.of(context)!.translate("total_ot")!} : ",
                        //         style: Theme.of(context).textTheme.bodyText1),
                        //     widget.payslipModel.totalOt == null
                        //         ? Text("")
                        //         : Expanded(
                        //             child: Text(
                        //               "\$${widget.payslipModel.totalOt}",
                        //               textScaleFactor: 1.1,
                        //               style: TextStyle(
                        //                   color: Colors.black,
                        //                   fontWeight: FontWeight.bold),
                        //             ),
                        //           ),
                        //   ],
                        // ),
                        SizedBox(height: 5),

                        Row(
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.translate("allowance")!} : ",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            widget.payslipModel.allowance == null
                                ? Text("")
                                : Expanded(
                                    child: Text(
                                      "\$${widget.payslipModel.allowance}",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                          ],
                        ),
                        // SizedBox(height: 5),

                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       "Email : ",
                        //       style: Theme.of(context).textTheme.bodyText1,
                        //     ),
                        //     widget.employeeModel.email == null
                        //         ? Text("")
                        //         : Expanded(
                        //             child: Text(
                        //               "${widget.employeeModel.email}",
                        //               style:
                        //                   Theme.of(context).textTheme.bodyText1,
                        //             ),
                        //           ),
                        //   ],
                        // ),
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
                                "${AppLocalizations.of(context)!.translate("wage_hour")!} : ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.orange[800]),
                              ),
                              Text(
                                "\$${widget.payslipModel.wageHour}",
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
                                "${AppLocalizations.of(context)!.translate("net_perday")!} : ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.orange[800]),
                              ),
                              Text(
                                "\$${widget.payslipModel.netPerday}",
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
                                "${AppLocalizations.of(context)!.translate("net_perhour")!} : ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(),
                              ),
                              Text(
                                "\$${widget.payslipModel.netPerHour}",
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
                                "${AppLocalizations.of(context)!.translate("total_att")!} : ",
                                style: Theme.of(context).textTheme.bodyText1),
                            Expanded(
                              child: Text(
                                "${widget.payslipModel.totalAttendance} days",
                                textScaleFactor: 1.1,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        // widget.payslipModel.deduction == null
                        //     ? Container()
                        //     : Row(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text(
                        //             "${AppLocalizations.of(context)!.translate("deduction")!} : ",
                        //             style:
                        //                 Theme.of(context).textTheme.bodyText1,
                        //           ),
                        //           Expanded(
                        //             child: Text(
                        //               "\$${widget.payslipModel.deduction}",
                        //               style:
                        //                   Theme.of(context).textTheme.bodyText1,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        // SizedBox(height: 5),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       "${AppLocalizations.of(context)!.translate("net_salary")!} : ",
                        //       style: Theme.of(context).textTheme.bodyText1,
                        //     ),
                        //     Expanded(
                        //       child: Text(
                        //         "\$${widget.payslipModel.netSalary}",
                        //         style: Theme.of(context).textTheme.bodyText1,
                        //       ),
                        //     ),
                        //   ],
                        // ),
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
                                "${AppLocalizations.of(context)!.translate("tax_salary")!} : ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.orange[800]),
                              ),
                              Text(
                                "\$${widget.payslipModel.taxSalary}",
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
                                "${AppLocalizations.of(context)!.translate("tax_allowance")!} : ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(),
                              ),
                              Text(
                                "\$${widget.payslipModel.taxAllowance}",
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
                                "${AppLocalizations.of(context)!.translate("gross_salary")!} : ",
                                style: Theme.of(context).textTheme.bodyText1),
                            Expanded(
                              child: Text(
                                "\$${widget.payslipModel.grossSalary}",
                                textScaleFactor: 1.1,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        widget.payslipModel.deduction == null
                            ? Container()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${AppLocalizations.of(context)!.translate("deduction")!} : ",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "\$${widget.payslipModel.deduction}",
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
                  SizedBox(height: 30),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //     color:
                      //         Colors.grey.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.lightBlue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 3,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.translate("net_salary")!}",
                          style: TextStyle(color: Colors.pink[400]),
                          textScaleFactor: 1.4,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("\$${widget.payslipModel.netSalary}",
                                textScaleFactor: 1.6,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)))
                      ],
                    ),
                  ),
                  // menuItemTile(
                  //   onPressed: () {},
                  //   overidingWidget: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [

                  //     ],
                  //   ),
                  //   iconBackgroundColor: Colors.white,
                  //   iconPath: '',
                  //   title: '',
                  // ),
                  SizedBox(height: 10),
                  // menuItemTile(

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
