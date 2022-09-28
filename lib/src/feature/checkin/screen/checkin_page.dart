import 'dart:io';
import 'package:e_learning/src/feature/account/bloc/index.dart';
import 'package:e_learning/src/feature/checkin/screen/attendance.dart';
import 'package:e_learning/src/shared/widget/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../appLocalizations.dart';

class CheckinPage extends StatefulWidget {
  // final String date;
  final String lat;
  final String lon;
  const CheckinPage({required this.lat, required this.lon});

  @override
  State<CheckinPage> createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  DateTime? date;
  DateTime dateNow = DateTime.now();
  String? checkin;

  String? checkinTime;
  double? lat;
  double? lot;
  String? createDate;
  String? mydate;
  @override
  void initState() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MM/dd/yyyy kk:mm:ss').format(now);
    String creDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
    checkin = formattedDate.toString();
    createDate = creDate.toString();
    mydate = formattedDate.substring(0, 10);
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
        title: Text("${AppLocalizations.of(context)!.translate("scanQr_in")!}"),
        backgroundColor: Colors.green[700],
      ),
      body: BlocListener(
        bloc: BlocProvider.of<AccountBloc>(context),
        listener: (context, state) {
          print(state);
          if (state is AddingCheckin) {
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
        print("checkin time $checkinTime");
        print("create date $checkinTime");
        print("date $mydate");
        // String mylat = lat.toString();
        // String mylong = lot.toString();
        // print(mylong);
        // print(mylat);
        // print(scanData.code.toString());
        String qrResult = scanData.code!.substring(0, 3);
        // var lastResult = qrResult.split(" ");
        print(qrResult);
        if (qrResult == "ban") {
          print('valid qr');
          print(mydate);
          print(createDate);
          print(checkinTime);
          print(widget.lat);
          print(widget.lon);
          BlocProvider.of<AccountBloc>(context).add(AddCheckinStarted(
            date: mydate!,
            createdDate: createDate!,
            checkinTime: checkinTime!,
            lat: widget.lat,
            lon: widget.lon,
          ));

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
