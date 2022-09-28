// import 'package:e_learning/src/feature/report/bloc/index.dart';
// import 'package:e_learning/src/feature/report/bloc/report_bloc.dart';
// import 'package:e_learning/src/shared/widget/standard_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// class ReportPage extends StatelessWidget {
//   const ReportPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: standardAppBar(context, "Report Page"),
//       body: Container(
//           margin: EdgeInsets.only(top: 10, bottom: 10), child: ReportBody()),
//     );
//   }
// }

// class ReportBody extends StatefulWidget {
//   const ReportBody({Key? key}) : super(key: key);

//   @override
//   State<ReportBody> createState() => _ReportBodyState();
// }

// class _ReportBodyState extends State<ReportBody> {
//   ReportBloc _reportBloc = ReportBloc();
//   final RefreshController _refreshController = RefreshController();
//   @override
//   void initState() {
//     _reportBloc.add(InitailizeReportStarted());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer(
//         bloc: _reportBloc,
//         builder: (context, state) {
//           //  return Center(child: CircularProgressIndicator());
//           if (state is InitializingReport) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (state is ErrorFetchingReport) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return SmartRefresher(
//             onRefresh: () {
//               _reportBloc.add(RefreshReportStarted());
//             },
//             onLoading: () {
//               _reportBloc.add(FetchReportStarted());
//               // BlocProvider.of<LeaveBloc>(context).add(FetchLeaveStarted());
//             },
//             enablePullDown: true,
//             enablePullUp: true,
//             controller: _refreshController,
//             child: ListView.builder(
//               cacheExtent: 1000,
//               // physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               // padding: EdgeInsets.only(left: 10, top: 10, right: 0),

//               itemCount: _reportBloc.myreport.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: EdgeInsets.only(bottom: 10.0, left: 8.0, right: 8.0),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey.withOpacity(0.2)),
//                     borderRadius: BorderRadius.circular(6.0),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 0,
//                         blurRadius: 3,
//                         offset: Offset(0, 0), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   child: Container(
//                     padding: EdgeInsets.all(8.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Row(
//                           // mainAxisAlignment:
//                           //     MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(right: 10),
//                               child: Text(
//                                 "Date :",
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             Text(
//                               "${_reportBloc.myreport[index].date}",
//                               style: TextStyle(
//                                   color: Colors.green,
//                                   fontWeight: FontWeight.bold),
//                             )
//                           ],
//                         ),
//                         SizedBox(
//                           height: 5.0,
//                         ),
//                         Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(right: 8),
//                               child: Text(
//                                 "Checkin Time :",
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   "${_reportBloc.myreport[index].checkinTime} ",
//                                   style: TextStyle(
//                                       color: Colors.red,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 // Text("- "),
//                                 // Text(
//                                 //   " ${BlocProvider.of<WantedBloc>(context).wantedList[index].maxPrice}",
//                                 //   style: TextStyle(
//                                 //       color: Colors.red,
//                                 //       fontWeight: FontWeight.bold),
//                                 // ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 5.0,
//                         ),
//                         Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(right: 8),
//                               child: Text(
//                                 "Checkin Status :",
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             Text(
//                               "${_reportBloc.myreport[index].checkitStatus} ${_reportBloc.myreport[index].checkinLate}",
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 5.0,
//                         ),
//                         Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(right: 8),
//                               child: Text(
//                                 "Checkout time :",
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             Text(
//                               "${_reportBloc.myreport[index].checkoutTime}",
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 5.0,
//                         ),
//                         Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(right: 8),
//                               child: Text(
//                                 "Checkout Status :",
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             Text(
//                               "${_reportBloc.myreport[index].checkoutStatus}  ${_reportBloc.myreport[index].checkoutLate}",
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//         listener: (context, state) {
//           if (state is FetchedReport) {
//             _refreshController.loadComplete();
//             _refreshController.refreshCompleted();
//           }
//           if (state is EndOfReportList) {
//             _refreshController.loadNoData();
//           }
//         });
//   }

//   @override
//   void dispose() {
//     _reportBloc.close();
//     super.dispose();
//   }
// }
