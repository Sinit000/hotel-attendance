import 'dart:io';

import 'package:e_learning/src/feature/account/bloc/index.dart';
import 'package:e_learning/src/feature/checkin/screen/attendance.dart';
import 'package:e_learning/src/shared/widget/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:developer';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../appLocalizations.dart';

class CheckoutPage extends StatefulWidget {
  final String id;
  final String lat;
  final String lon;
  CheckoutPage({required this.id, required this.lat, required this.lon});
  // final String locationId;
  // final String timetableId;
  // CheckoutPage({required this.locationId, required this.timetableId});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // AccountBloc accountBloc = AccountBloc();
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  DateTime? date;
  DateTime dateNow = DateTime.now();
  String? checkin;

  String? checkinTime;
  double? lat;
  String? mydate;
  double? lot;
  // PermissionStatus? _permissionGranted;
  // LocationData? _location;
  // GoogleMapController? mapController;
  // LatLng? _initialcameraposition;
  // final Location location = Location();
  // Future<void> _myLocation() async {
  //   _location = await location.getLocation();

  //   setState(() {
  //     lat = _location!.latitude;
  //     lot = _location!.longitude;
  //   });
  //   print(lat);
  //   print(lot);
  //   // _initialcameraposition = LatLng(_location.latitude, _location.longitude);
  //   // location.onLocationChanged.listen((LocationData currentLocation) {
  //   //   _location = currentLocation;
  //   //   _initialcameraposition = LatLng(_location.latitude, _location.longitude);
  //   // });
  // }

  // Future<void> _checkPermissions() async {
  //   final PermissionStatus permissionGrantedResult =
  //       await location.hasPermission();
  //   setState(() {
  //     _permissionGranted = permissionGrantedResult;
  //     // print("here is my permission " + permissionGrantedResult.toString());
  //   });
  // }

  // Future<void> _requestPermission() async {
  //   if (_permissionGranted == PermissionStatus.granted ||
  //       _permissionGranted == PermissionStatus.grantedLimited) {
  //     final PermissionStatus permissionRequestedResult =
  //         await location.requestPermission();
  //     setState(() {
  //       _permissionGranted = permissionRequestedResult;
  //     });
  //     if (permissionRequestedResult == PermissionStatus.granted) {
  //       _myLocation();
  //     } else {
  //       // locationDialog();
  //     }
  //   } else {
  //     _initialcameraposition = LatLng(11.566151053634218, 104.88413827054434);
  //     final PermissionStatus permissionRequestedResult =
  //         await location.requestPermission();
  //     setState(() {
  //       _permissionGranted = permissionRequestedResult;
  //     });
  //     if (permissionRequestedResult == PermissionStatus.granted) {
  //       _myLocation();
  //     } else {
  //       // locationDialog();
  //     }
  //   }
  // }

  // @override
  // void initState() {

  //   super.initState();
  // }
  String? today;

  @override
  void initState() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MM/dd/yyyy kk:mm:ss').format(now);
    // String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    checkin = formattedDate.toString();
    mydate = formattedDate.substring(0, 10);
    String formattDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    today = formattDate.substring(0, 10);
    // _checkPermissions();
    // _requestPermission();
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("${AppLocalizations.of(context)!.translate("scanQr_out")!}"),
        backgroundColor: Colors.green[700],
      ),
      body: BlocListener(
        bloc: BlocProvider.of<AccountBloc>(context),
        listener: (context, state) {
          print(state);
          if (state is AddingCheckout) {
            // Navigator.pop(context);
            EasyLoading.show(status: 'loading...');
          }
          if (state is AddedCheckin) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess("Success");
            Navigator.pop(context);
            // accountBloc.add(FetchAccountStarted());
            print("success");
          }
          if (state is ErrorAddingCheckInOut) {
            EasyLoading.dismiss();
            errorSnackBar(text: state.error.toString(), context: context);
            controller!.resumeCamera();
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(flex: 5, child: _buildQrView(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext c) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      await controller.pauseCamera();
      if (result == null) {
        print("Please scan a correct qr code");
      } else {
        checkinTime = checkin!.substring(11, 19);
        // String mylat = lat.toString();
        // String mylong = lot.toString();
        // print(mylong);
        // print(mylat);
        // print(scanData.code.toString());
        String qrResult = scanData.code!.substring(0, 3);
        print(qrResult);
        if (qrResult == "ban") {
          BlocProvider.of<AccountBloc>(context).add(AddCheckoutStarted(
              date: mydate!,
              id: widget.id,
              checkoutTime: checkinTime!,
              lat: widget.lat,
              lon: widget.lon,
              createdDate: today!));
          print("success");
        } else {
          print("wrong qr");
          // EasyLoading.showError("Wrong Qr Code");
          controller.resumeCamera();
          // errorSnackBar(text: "Sorry Wrong QR Code", context: context);
          // Navigator.pop(context);
          print("wrong");
        }
      }
    });
  }

  @override
  void dispose() {
    controller!.dispose();

    super.dispose();
  }
}
