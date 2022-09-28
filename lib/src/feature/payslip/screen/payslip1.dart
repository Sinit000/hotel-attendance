// import 'package:flutter/material.dart';

// class PaySlippage extends StatelessWidget {
//   // const PaySlippage({Key? key}) : super(key: key);
//   List<String> paylist = [
//     "January",
//     "February",
//     "March",
//     "April",
//     "May",
//     "June",
//     "July",
//     "August",
//     "September",
//     "October",
//     "November",
//     "December"
//   ];
//   List<String> numMonth = [
//     "01",
//     "02",
//     "03",
//     "04",
//     "05",
//     "06",
//     "07",
//     "08",
//     "09",
//     "10",
//     "11",
//     "12"
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: _buildAppBar(context),
//       body: _buildBody(context),
//     );
//   }

//   // _buildAppBar(BuildContext context) {
//   //   return AppBar(
//   //     brightness: Brightness.light,
//   //     elevation: 0,
//   //     backgroundColor: Colors.blue,
//   //     title: Text(
//   //       "Payslip",
//   //       textScaleFactor: 1.1,
//   //     ),
//   //     actions: [
        
//   //     ],
//   //   );
//   // }

//   _buildBody(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(left: 15, right: 10, top: 20),
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.only(left: 20),
//             alignment: Alignment.centerLeft,
//             child: DropdownButton<String>(
//               hint: Text(
              
//                 "This year",
//                 textScaleFactor: 1,
//               ),
//               items: ['Last year', 'This year', 'Next year', "Custom"]
//                   .map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               onChanged: (value) {
               
//               },
//             ),
//           ),
//           Container(
//             width: double.infinity,
//             height: 10,
//             color: Colors.transparent,
//           ),
//           Expanded(
//             child: ListView.builder(
//                 itemCount: paylist.length,
//                 itemBuilder: (con, index) {
//                   return InkWell(
//                     onTap: () {
//                       print("month ${paylist[index]}");
                     
//                     },
//                     child: Container(
//                       // margin: EdgeInsets.only(top: 10),
//                       // color: Colors.redAccent,
//                       height: 90,
//                       width: MediaQuery.of(context).size.width,
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 // padding: EdgeInsets.only(left: 10),
//                                 height: 50,
//                                 width: 50,
//                                 decoration: BoxDecoration(
//                                   color: Colors.purple,
//                                   borderRadius: BorderRadius.circular(50),

                                 
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     "${numMonth[index]}".toUpperCase(),
//                                     style: TextStyle(color: Colors.white),
//                                     textScaleFactor: 1.5,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "${paylist[index]}",
//                                     textScaleFactor: 1.2,
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold),
//                                   ),
//                                   SizedBox(
//                                     height: 4,
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.only(top: 3),
//                                     child: Text(
//                                       "01/04/2022 - 01/05/2022",
//                                       style: TextStyle(color: Colors.grey[500]),
//                                     ),
//                                   ),
                                 
//                                 ],
//                               ),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               // InkWell(
//                               //   child: Icon(Icons.navigate_next),
//                               // )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 4,
//                           ),
//                           Divider(
//                             height: 3,
//                             // color: Colors.blueAccent,
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 }),
//           )
//         ],
//       ),
//     );
//   }
// }

// class PayslipBody extends StatefulWidget {
//   const PayslipBody({Key? key}) : super(key: key);

//   @override
//   State<PayslipBody> createState() => _PayslipBodyState();
// }

// class _PayslipBodyState extends State<PayslipBody> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
