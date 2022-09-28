// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:anakut_delivery/bloc/deliveryDetail/delivery_detail_bloc.dart';
// import 'package:anakut_delivery/bloc/deliveryDetail/delivery_detail_event.dart';
// import 'package:anakut_delivery/bloc/deliveryDetail/delivery_detail_state.dart';
// import 'package:anakut_delivery/bloc/deliverying/delivery_bloc.dart';
// import 'package:anakut_delivery/bloc/deliverying/delivery_event.dart';
// import 'package:anakut_delivery/bloc/deliverying/delivery_state.dart';
// import 'package:anakut_delivery/component/loading_dailog.dart';
// import 'package:anakut_delivery/model/confrim_delivery_model.dart';
// import 'package:anakut_delivery/model/user_model.dart';
// import 'package:anakut_delivery/pages/language/app_localizations.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// // import 'package:qrscan/qrscan.dart' as scanner;

// class ScanQrcodePage extends StatefulWidget {
//   final UserModel userModel;
//   const ScanQrcodePage({Key key, @required this.userModel}) : super(key: key);

//   @override
//   ScanQrcodePageState createState() => ScanQrcodePageState();
// }

// class ScanQrcodePageState extends State<ScanQrcodePage> {
//   GlobalKey key = GlobalKey();
//   Uint8List bytes = Uint8List(0);
//   static TextEditingController idController;
//   static TextEditingController phoneController;
//   static TextEditingController totalController;

//   Barcode result;
//   QRViewController controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

//   final DeliveryBloc deliveryBloc = DeliveryBloc();
//   DeliveryDetailBloc deliveryDetailBloc;

//   Future<bool> _errorMessage(String errorMessage) {
//     return showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text('Alert !'),
//                 content: Text(errorMessage),
//                 actions: <Widget>[
//                   FlatButton(
//                     onPressed: () {
//                       Navigator.of(context).pop(false);
//                     },
//                     child: Text('Yes'),
//                   ),
//                 ],
//               );
//             }) ??
//         false;
//   }

//   _onConfirmPickup() {
//     deliveryBloc.add(PostConfirmPickup(
//         orderId: int.parse(idController.text),
//         accessToken: widget.userModel.token));
//   }

//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller.pauseCamera();
//     }
//     controller.resumeCamera();
//   }

//   @override
//   void initState() {
//     super.initState();
//     deliveryDetailBloc = DeliveryDetailBloc();
//     idController = TextEditingController();
//     phoneController = TextEditingController();
//     totalController = TextEditingController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//           title: Text("Scan QR code"),
//           backgroundColor: Colors.transparent,
//           elevation: 0),
//       // backgroundColor: Colors.transparent,
//       body: Column(
//         children: [
//           Expanded(flex: 5, child: _buildQrView(context)),
//           Expanded(
//             flex: 5,
//             child: Container(
//               padding: EdgeInsets.only(left: 10.0, right: 10.0),
//               child: _qrCodeWidget(this.bytes, context),
//             ),
//           ),
//         ],
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () => navigatePageOpenCamera(),
//       //   tooltip: 'Open camera',
//       //   child: const Icon(Icons.qr_code_scanner),
//       // ),
//       // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//     );
//   }

//   Widget _qrCodeWidget(Uint8List bytes, BuildContext context) {
//     return BlocListener(
//         cubit: deliveryBloc,
//         listener: (context, state) {
//           if (state is ConfirmDeliveryLoading) {
//             LoadingDialogs.showLoadingDialog(context, key);
//           }
//           if (state is ConfirmDeliveryLoaded) {
//             Navigator.of(context).pop();
//             EasyLoading.showSuccess(
//                 '${AppLocalizations.of(context).translate("success")}!');
//             EasyLoading.instance
//               ..displayDuration = const Duration(milliseconds: 500);
//             Navigator.of(context).pop();
//           }
//           if (state is ErrorConfirmDelivery) {
//             Navigator.of(context).pop();
//             _errorMessage(state.error);
//           }
//         },
//         child: BlocBuilder(
//             cubit: deliveryDetailBloc,
//             builder: (context, state) {
//               if (state is InitializingDetail) {
//                 return Container(
//                   padding: EdgeInsets.all(10.0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       SizedBox(height: 10.0),
//                       Text(
//                         AppLocalizations.of(context)
//                             .translate("transactionDetails"),
//                         style: TextStyle(
//                           fontSize: 20.0,
//                         ),
//                       ),
//                       SizedBox(height: 20.0),
//                       Divider(),
//                       TextFormField(
//                         style: TextStyle(
//                           fontSize: 18,
//                         ),
//                         // controller: this._idController,
//                         enabled: false,
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           prefixText: "Invoice No : ",
//                           hintStyle: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.w300),
//                           contentPadding:
//                               EdgeInsets.symmetric(horizontal: 7, vertical: 10),
//                         ),
//                       ),
//                       TextFormField(
//                         style: TextStyle(
//                           fontSize: 18,
//                         ),
//                         // controller: this._phoneController,
//                         enabled: false,
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           prefixText: "Tel : ",
//                           hintStyle: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.w300),
//                           contentPadding:
//                               EdgeInsets.symmetric(horizontal: 7, vertical: 10),
//                         ),
//                       ),
//                       TextFormField(
//                         style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.orange[900],
//                             fontWeight: FontWeight.bold),
//                         // controller: this._totalController,
//                         enabled: false,
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           prefixText: "Total : ",
//                           hintStyle: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.w300),
//                           contentPadding:
//                               EdgeInsets.symmetric(horizontal: 7, vertical: 10),
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           border: Border(
//                               top:
//                                   BorderSide(color: Colors.grey[200], width: 1),
//                               bottom: BorderSide(
//                                   color: Colors.grey[200], width: 1)),
//                         ),
//                         margin: EdgeInsets.only(top: 20.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Expanded(
//                               flex: 5,
//                               child: GestureDetector(
//                                 child: Container(
//                                   padding: EdgeInsets.symmetric(vertical: 10.0),
//                                   // color: Colors.red,
//                                   decoration: BoxDecoration(
//                                     border: Border(
//                                         right: BorderSide(
//                                             color: Colors.grey[200], width: 1)),
//                                   ),
//                                   width: double.infinity,
//                                   child: Center(
//                                     child: Text(
//                                       AppLocalizations.of(context)
//                                           .translate("cancel"),
//                                       textScaleFactor: 1.2,
//                                       style: TextStyle(color: Colors.blue),
//                                       // textAlign: TextAlign.left,
//                                     ),
//                                   ),
//                                 ),
//                                 onTap: () => Navigator.of(context).pop(),
//                               ),
//                             ),
//                             // Text('|',
//                             //     style: TextStyle(
//                             //         fontSize: 15, color: Colors.black26)),

//                             Expanded(
//                               flex: 5,
//                               child: GestureDetector(
//                                 onTap: () {},
//                                 child: Container(
//                                   padding: EdgeInsets.symmetric(vertical: 10.0),
//                                   width: double.infinity,
//                                   child: Center(
//                                     child: Text(
//                                       AppLocalizations.of(context)
//                                           .translate("accept"),
//                                       textScaleFactor: 1.2,
//                                       style: TextStyle(color: Colors.blue),
//                                       // textAlign: TextAlign.right,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//               if (state is FetchingDetail) {
//                 return Card(
//                   elevation: 6,
//                   child: Container(
//                     padding: EdgeInsets.all(10.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         SizedBox(height: 10.0),
//                         Text(
//                           AppLocalizations.of(context)
//                               .translate("transactionDetails"),
//                           style: TextStyle(
//                             fontSize: 20.0,
//                           ),
//                         ),
//                         SizedBox(height: 20.0),
//                         Divider(),
//                         Center(
//                           child: CupertinoActivityIndicator(),
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             border: Border(
//                                 top: BorderSide(
//                                     color: Colors.grey[200], width: 1),
//                                 bottom: BorderSide(
//                                     color: Colors.grey[200], width: 1)),
//                           ),
//                           margin: EdgeInsets.only(top: 20.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Expanded(
//                                 flex: 5,
//                                 child: GestureDetector(
//                                   child: Container(
//                                     padding:
//                                         EdgeInsets.symmetric(vertical: 10.0),
//                                     // color: Colors.red,
//                                     decoration: BoxDecoration(
//                                       border: Border(
//                                           right: BorderSide(
//                                               color: Colors.grey[200],
//                                               width: 1)),
//                                     ),
//                                     width: double.infinity,
//                                     child: Center(
//                                       child: Text(
//                                         AppLocalizations.of(context)
//                                             .translate("cancel"),
//                                         textScaleFactor: 1.2,
//                                         style: TextStyle(color: Colors.blue),
//                                         // textAlign: TextAlign.left,
//                                       ),
//                                     ),
//                                   ),
//                                   onTap: () => Navigator.of(context).pop(),
//                                 ),
//                               ),
//                               // Text('|',
//                               //     style: TextStyle(
//                               //         fontSize: 15, color: Colors.black26)),

//                               Expanded(
//                                 flex: 5,
//                                 child: GestureDetector(
//                                   onTap: () {},
//                                   child: Container(
//                                     padding:
//                                         EdgeInsets.symmetric(vertical: 10.0),
//                                     width: double.infinity,
//                                     child: Center(
//                                       child: Text(
//                                         AppLocalizations.of(context)
//                                             .translate("accept"),
//                                         textScaleFactor: 1.2,
//                                         style: TextStyle(color: Colors.blue),
//                                         // textAlign: TextAlign.right,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }
//               if (state is ErrorFetchingDetail) {
//                 return Center(
//                   child: Text(
//                     "Please try again",
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 );
//               } else {
//                 return Card(
//                   elevation: 6,
//                   child: Container(
//                     padding: EdgeInsets.all(10.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         SizedBox(height: 10.0),
//                         Text(
//                           AppLocalizations.of(context)
//                               .translate("transactionDetails"),
//                           style: TextStyle(
//                             fontSize: 20.0,
//                           ),
//                         ),
//                         SizedBox(height: 20.0),
//                         Divider(),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 3,
//                               child: Text(
//                                 'Invoice No : ',
//                                 textScaleFactor: 1.1,
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w300,
//                                     color: Colors.grey[700]),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 7,
//                               child: Text(
//                                 deliveryDetailBloc.deliveryDetailModel.id
//                                     .toString(),
//                                 textScaleFactor: 1.2,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10.0),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 3,
//                               child: Text(
//                                 'Tel : ',
//                                 textScaleFactor: 1.1,
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w300,
//                                     color: Colors.grey[700]),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 7,
//                               child: Text(
//                                 deliveryDetailBloc.deliveryDetailModel.phone
//                                     .toString(),
//                                 textScaleFactor: 1.2,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10.0),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 3,
//                               child: Text(
//                                 'Delivery Fee : ',
//                                 textScaleFactor: 1.1,
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w300,
//                                     color: Colors.grey[700]),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 7,
//                               child: Text(
//                                 deliveryDetailBloc.deliveryDetailModel.fee
//                                         .toString() +
//                                     " \$",
//                                 textScaleFactor: 1.2,
//                                 style: TextStyle(
//                                     color: Colors.redAccent,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10.0),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 3,
//                               child: Text(
//                                 'Total : ',
//                                 textScaleFactor: 1.1,
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w300,
//                                     color: Colors.grey[700]),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 7,
//                               child: Text(
//                                 deliveryDetailBloc
//                                         .deliveryDetailModel.grandTotal
//                                         .toString() +
//                                     " \$",
//                                 textScaleFactor: 1.2,
//                                 style: TextStyle(
//                                     color: Colors.redAccent,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             border: Border(
//                                 top: BorderSide(
//                                     color: Colors.grey[300], width: 0.7)),
//                           ),
//                           margin: EdgeInsets.only(top: 20.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: <Widget>[
//                               Expanded(
//                                 flex: 5,
//                                 child: GestureDetector(
//                                   child: Container(
//                                     width: double.infinity,
//                                     padding:
//                                         EdgeInsets.symmetric(vertical: 10.0),
//                                     decoration: BoxDecoration(
//                                       border: Border(
//                                           right: BorderSide(
//                                               color: Colors.grey[300],
//                                               width: 0.7)),
//                                     ),
//                                     // color: Colors.red,
//                                     child: Center(
//                                       child: Text(
//                                         AppLocalizations.of(context)
//                                             .translate("cancel"),
//                                         style: TextStyle(color: Colors.blue),
//                                         textScaleFactor: 1.2,
//                                       ),
//                                     ),
//                                   ),
//                                   onTap: () => Navigator.of(context).pop(),
//                                 ),
//                               ),
//                               // Text('|',
//                               //     style: TextStyle(
//                               //         fontSize: 15, color: Colors.black26)),
//                               Expanded(
//                                 flex: 5,
//                                 child: GestureDetector(
//                                   onTap: () => _onConfirmPickup(),
//                                   child: Container(
//                                     padding:
//                                         EdgeInsets.symmetric(vertical: 10.0),
//                                     // color: Colors.red,
//                                     width: double.infinity,
//                                     child: Center(
//                                       child: Text(
//                                         AppLocalizations.of(context)
//                                             .translate("accept"),
//                                         style: TextStyle(color: Colors.blue),
//                                         textScaleFactor: 1.2,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }
//             }));
//   }

//   Widget _buildQrView(BuildContext c) {
//     // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//             MediaQuery.of(context).size.height < 400)
//         ? 150.0
//         : 300.0;
//     // To ensure the Scanner view is properly sizes after rotation
//     // we need to listen for Flutter SizeChanged notification and update controller
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       overlay: QrScannerOverlayShape(
//           borderColor: Colors.red,
//           borderRadius: 10,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: scanArea),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) async {
//       setState(() {
//         result = scanData;
//       });
//       await controller.pauseCamera();
//       if (result == null) {
//         print("Please scan a correct qr code");
//       } else {
//         // print(scanData.code.toString());
//         String qrResult = scanData.code.toString();
//         Map results = jsonDecode(qrResult);
//         var scanResult = UserScan.fromJson(results);
//         idController.text = scanResult.id.toString();
//         phoneController.text = scanResult.phone;
//         totalController.text = scanResult.total;
//         deliveryDetailBloc.add(GetDeliveryDetail(
//             accessToken: widget.userModel.token,
//             id: int.parse(scanResult.id.toString())));
//       }
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     deliveryBloc.close();
//     super.dispose();
//   }
// }
