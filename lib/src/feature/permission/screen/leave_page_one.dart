// import 'package:e_learning/src/config/routes/routes.dart';
// import 'package:e_learning/src/feature/permission/bloc/index.dart';
// import 'package:e_learning/src/feature/permission/screen/leave_page_one.dart';
// import 'package:e_learning/src/shared/widget/error_snackbar.dart';
// import 'package:e_learning/src/shared/widget/loadin_dialog.dart';
// import 'package:e_learning/src/shared/widget/standard_appbar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:flutter_picker/flutter_picker.dart';
// import 'package:intl/intl.dart';

// import 'add_leave.dart';
// import 'edit_leave.dart';

// LeaveBloc leaveBloc = LeaveBloc();

// class LeavePage extends StatelessWidget {
//   final String mydate;
//   const LeavePage({this.mydate = "This week"});

//   @override
//   Widget build(BuildContext context) {
//     // return LeaveBody(
//     //   mydate: mydate,
//     // );

//     // return BlocProvider(
//     //     create: (BuildContext context) =>
//     //         LeaveBloc()..add(InitializeStarted(dateRange: "Today")),
//     //     child: LeaveBody());
//     return Scaffold(
//       appBar: standardAppBar(context, "Leave Page"),
//       body: Container(
//           margin: EdgeInsets.only(top: 10, bottom: 10),
//           child: LeaveBody(
//             mydate: mydate,
//           )),
//       floatingActionButton: Container(
//         child: FloatingActionButton(
//             backgroundColor: Colors.lightBlueAccent,
//             child: Icon(Icons.add),
//             elevation: 0,
//             onPressed: () {
//               Navigator.pushNamed(context, addLeave);
//             }),
//       ),
//     );
//   }
// }

// class LeaveBody extends StatefulWidget {
//   final String mydate;
//   const LeaveBody({required this.mydate});
//   @override
//   State<LeaveBody> createState() => _LeaveBodyState();
// }

// class _LeaveBodyState extends State<LeaveBody> {
//   final RefreshController _refreshController = RefreshController();
//   String? mydateRage;
//   @override
//   void initState() {
//     leaveBloc.add(InitializeStarted(dateRange: widget.mydate));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer(
//         bloc: leaveBloc,
//         builder: (context, state) {
//           //  return Center(child: CircularProgressIndicator());
//           if (state is InitializingLeave) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (state is InitializedLeave || state is FetchedLeave) {
//             return Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(left: 20),
//                   alignment: Alignment.centerLeft,
//                   child: DropdownButton<String>(
//                     hint: Text(
//                       // leaveBloc.dateRange!,
//                       leaveBloc.dateRange!.contains("to")
//                           ? leaveBloc.dateRange!
//                           : leaveBloc.dateRange!,
//                       textScaleFactor: 1,
//                     ),
//                     items: [
//                       'Today',
//                       'This week',
//                       'This month',
//                       'This year',
//                       "Custom"
//                     ].map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       if (value == "Custom") {
//                         showPickerDateRange(context);
//                       } else
//                         mydateRage = value;
//                       print(mydateRage);
//                       leaveBloc.add(InitializeStarted(dateRange: value));
//                     },
//                   ),
//                 ),
//                 Container(
//                   width: double.infinity,
//                   height: 10,
//                   color: Colors.transparent,
//                 ),
//                 leaveBloc.myleave.length == 0
//                     ? Container(
//                         child: Text("No data"),
//                       )
//                     : Expanded(
//                         child: SmartRefresher(
//                         onRefresh: () {
//                           leaveBloc.add(RefreshLeaveStarted());
//                         },
//                         onLoading: () {
//                           if (leaveBloc.state is EndOfLeaveList) {
//                             _refreshController.loadNoData();
//                           } else {
//                             print(mydateRage);
//                             mydateRage == null
//                                 ? leaveBloc.add(
//                                     FetchLeaveStarted(dateRange: widget.mydate))
//                                 : leaveBloc.add(
//                                     FetchLeaveStarted(dateRange: mydateRage));
//                             // BlocProvider.of<ProductListingBloc>(context)
//                             //     .add(FetchProductListStarted(arg: widget.category.id));
//                           }
//                           // BlocProvider.of<LeaveBloc>(context).add(FetchLeaveStarted());
//                         },
//                         enablePullDown: true,
//                         enablePullUp: true,
//                         controller: _refreshController,
//                         child: SingleChildScrollView(
//                           child: Column(
//                             // addAutomaticKeepAlives: true,
//                             children: [
//                               ListView.builder(
//                                 cacheExtent: 1000,
//                                 physics: NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 // padding: EdgeInsets.only(left: 10, top: 10, right: 0),

//                                 itemCount: leaveBloc.myleave.length,
//                                 itemBuilder: (context, index) {
//                                   return Container(
//                                     margin: EdgeInsets.only(
//                                         bottom: 10.0, left: 8.0, right: 8.0),
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                           color: Colors.grey.withOpacity(0.2)),
//                                       borderRadius: BorderRadius.circular(6.0),
//                                       color: Colors.white,
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey.withOpacity(0.5),
//                                           spreadRadius: 0,
//                                           blurRadius: 3,
//                                           offset: Offset(0,
//                                               0), // changes position of shadow
//                                         ),
//                                       ],
//                                     ),
//                                     child: Container(
//                                       padding: EdgeInsets.all(8.0),
//                                       child: Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Row(
//                                             // mainAxisAlignment:
//                                             //     MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     right: 10),
//                                                 child: Text(
//                                                   "Date :",
//                                                   style: TextStyle(
//                                                       color: Colors.black),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 "${leaveBloc.myleave[index].date}",
//                                                 style: TextStyle(
//                                                     color: Colors.green,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               )
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 5.0,
//                                           ),
//                                           Row(
//                                             children: [
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     right: 8),
//                                                 child: Text(
//                                                   "Reason :",
//                                                   style: TextStyle(
//                                                       color: Colors.black),
//                                                 ),
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Text(
//                                                     "${leaveBloc.myleave[index].reason} ",
//                                                     style: TextStyle(
//                                                         color: Colors.red,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   ),
//                                                   // Text("- "),
//                                                   // Text(
//                                                   //   " ${BlocProvider.of<WantedBloc>(context).wantedList[index].maxPrice}",
//                                                   //   style: TextStyle(
//                                                   //       color: Colors.red,
//                                                   //       fontWeight: FontWeight.bold),
//                                                   // ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 5.0,
//                                           ),
//                                           Row(
//                                             children: [
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     right: 8),
//                                                 child: Text(
//                                                   "Duration :",
//                                                   style: TextStyle(
//                                                       color: Colors.black),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 "${leaveBloc.myleave[index].number}",
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 5.0,
//                                           ),
//                                           Row(
//                                             children: [
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     right: 8),
//                                                 child: Text(
//                                                   "From date :",
//                                                   style: TextStyle(
//                                                       color: Colors.black),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 "${leaveBloc.myleave[index].fromDate}",
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 5.0,
//                                           ),
//                                           Row(
//                                             children: [
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     right: 8),
//                                                 child: Text(
//                                                   "Status :",
//                                                   style: TextStyle(
//                                                       color: Colors.black),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 "${leaveBloc.myleave[index].status}",
//                                               ),
//                                             ],
//                                           ),
//                                           leaveBloc.myleave[index].status ==
//                                                   "pending"
//                                               ? Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.end,
//                                                   children: [
//                                                     CupertinoButton(
//                                                         padding:
//                                                             EdgeInsets.all(1.0),
//                                                         color: Colors.green,
//                                                         child: Row(
//                                                           children: [
//                                                             Icon(Icons.edit),
//                                                           ],
//                                                         ),
//                                                         onPressed: () {
//                                                           Navigator.push(
//                                                               context,
//                                                               MaterialPageRoute(
//                                                                   builder: (con) =>
//                                                                       EditLeave(
//                                                                         leaveModel:
//                                                                             leaveBloc.myleave[index],
//                                                                       )));
//                                                         }),
//                                                     SizedBox(
//                                                       width: 5,
//                                                     ),
//                                                     CupertinoButton(
//                                                         padding:
//                                                             EdgeInsets.all(1.0),
//                                                         color: Colors.red,
//                                                         child: Row(
//                                                           children: [
//                                                             Icon(Icons.delete),
//                                                           ],
//                                                         ),
//                                                         onPressed: () {
//                                                           print(
//                                                               "id ${leaveBloc.myleave[index].id}");
//                                                           leaveBloc.add(
//                                                               DeleteLeaveStarted(
//                                                                   id: leaveBloc
//                                                                       .myleave[
//                                                                           index]
//                                                                       .id));
//                                                         }),
//                                                   ],
//                                                 )
//                                               : Container(),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       )),
//               ],
//             );
//           }
//           if (state is ErrorFetchingLeave) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return Center();
//         },
//         listener: (context, state) {
//           if (state is FetchedLeave) {
//             _refreshController.loadComplete();
//             _refreshController.refreshCompleted();
//           }
//           if (state is EndOfLeaveList) {
//             _refreshController.loadNoData();
//           }
//           if (state is AddingLeave) {
//             EasyLoading.show(status: 'loading...');
//           } else if (state is ErrorAddingLeave) {
//             EasyLoading.dismiss();
//             EasyLoading.showError(state.error.toString());
//           } else if (state is AddedLeave) {
//             EasyLoading.dismiss();
//             EasyLoading.showSuccess('Success');
//           }
//         });
//   }

//   showPickerDateRange(BuildContext context) {
//     String? _startDate;
//     String? _endDate;

//     final DateFormat formatter = DateFormat('yyyy-MM-dd');
//     Picker ps = Picker(
//         confirmText: "Confirm",
//         cancelText: "Cancel",
//         hideHeader: true,
//         adapter: DateTimePickerAdapter(
//             type: PickerDateTimeType.kYMD, isNumberMonth: false),
//         onConfirm: (Picker picker, List value) {
//           _startDate = formatter
//               .format((picker.adapter as DateTimePickerAdapter).value!);
//         });

//     Picker pe = Picker(
//         hideHeader: true,
//         adapter: DateTimePickerAdapter(type: PickerDateTimeType.kYMD),
//         onConfirm: (Picker picker, List value) {
//           _endDate = formatter
//               .format((picker.adapter as DateTimePickerAdapter).value!);
//         });

//     List<Widget> actions = [
//       TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text(PickerLocalizations.of(context).cancelText!)),
//       TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//             ps.onConfirm!(ps, ps.selecteds);
//             pe.onConfirm!(pe, pe.selecteds);
//             leaveBloc
//                 .add(InitializeStarted(dateRange: "$_startDate/$_endDate"));
//           },
//           child: Text(PickerLocalizations.of(context).confirmText!))
//     ];

//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Select Date"),
//             actions: actions,
//             content: Container(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Text("Start :"),
//                   ps.makePicker(),
//                   Text("End :"),
//                   pe.makePicker()
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }
