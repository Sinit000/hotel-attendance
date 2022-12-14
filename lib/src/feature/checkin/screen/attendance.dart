import 'package:e_learning/src/feature/account/bloc/index.dart';
import 'package:e_learning/src/feature/account/model/account_model.dart';
import 'package:e_learning/src/feature/auth/bloc/authentication_bloc.dart';
import 'package:e_learning/src/feature/checkin/screen/checkin_page.dart';
import 'package:e_learning/src/feature/checkin/screen/checkout_page.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';

import '../../../../appLocalizations.dart';
import 'package:intl/intl.dart';

AccountBloc attendanceBloc = AccountBloc();

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  DateTime? date;
  DateTime dateNow = DateTime.now();
  String? checkindate;
  PermissionStatus? _permissionGranted;
  LocationData? _location;
  // GoogleMapController? mapController;
  // LatLng? _initialcameraposition;
  double? lat;
  double? lot;
  final Location location = Location();
  Future<void> _myLocation() async {
    _location = await location.getLocation();

    setState(() {
      lat = _location!.latitude;
      lot = _location!.longitude;
    });
    print(lat);
    print(lot);
    // _initialcameraposition = LatLng(_location.latitude, _location.longitude);
    // location.onLocationChanged.listen((LocationData currentLocation) {
    //   _location = currentLocation;
    //   _initialcameraposition = LatLng(_location.latitude, _location.longitude);
    // });
  }

  Future<void> _checkPermissions() async {
    final PermissionStatus permissionGrantedResult =
        await location.hasPermission();
    setState(() {
      _permissionGranted = permissionGrantedResult;
      // print("here is my permission " + permissionGrantedResult.toString());
    });
  }

  Future<void> _requestPermission() async {
    if (_permissionGranted == PermissionStatus.granted ||
        _permissionGranted == PermissionStatus.grantedLimited) {
      final PermissionStatus permissionRequestedResult =
          await location.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
      });
      if (permissionRequestedResult == PermissionStatus.granted) {
        print("location grated");
        _myLocation();
      } else {
        print("location denied");
        // locationDialog();
      }
    } else {
      // _initialcameraposition = LatLng(11.566151053634218, 104.88413827054434);
      final PermissionStatus permissionRequestedResult =
          await location.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
      });
      if (permissionRequestedResult == PermissionStatus.granted) {
        _myLocation();
      } else {
        // locationDialog();
      }
    }
  }

  String? mydate = "";
  void initState() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MM/dd/yyyy kk:mm:ss').format(now);
    String formatDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
    // String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    checkindate = formatDate.toString();
    // mydate = "${dateNow.month}/${dateNow.day}/${dateNow.year}";
    mydate = formattedDate.substring(0, 10);
    // accountBloc.add(FetchAccountStarted());
    _checkPermissions();
    _requestPermission();
    attendanceBloc.add(FetchCheckAccountStarted(todayDate: checkindate!.substring(0, 10)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<AccountBloc>(context).add(
    //     FetchCheckAccountStarted(todayDate: checkindate!.substring(0, 10)));
    print(checkindate);
    print(mydate);
    return Scaffold(
        appBar: standardAppBar(context,
            "${AppLocalizations.of(context)!.translate("check_attendane")!}"),
        body: BlocConsumer(
            bloc: attendanceBloc,
            builder: (context, state) {
              print(state);

              if (state is FetchedCheckAccount) {
                if (attendanceBloc
                        .check!
                        .checkinStatus ==
                    "false") {
                  return checkin(
                      accountModel:
                          attendanceBloc.check!);
                } else if (attendanceBloc
                        .check!
                        .checkinStatus ==
                    "true") {
                  return checkOut(
                      accountModel:
                          attendanceBloc.check!);
                } else if (attendanceBloc
                            .check!
                            .checkinStatus ==
                        "leave" ||
                    attendanceBloc
                            .check!
                            .checkinStatus ==
                        "absent") {
                  return SingleChildScrollView(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 50),
                            width:
                                (MediaQuery.of(context).size.width / 10) * 4.5,
                            height:
                                (MediaQuery.of(context).size.width / 10) * 4.5,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.red.withOpacity(0.3)),
                            child: Container(
                              padding: EdgeInsets.all(25),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.red),
                              child: Image(
                                image: AssetImage("assets/icon/x-mark.png"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              "${AppLocalizations.of(context)!.translate("leave_attendance")!}",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              "${AppLocalizations.of(context)!.translate("date")!} ${checkindate!}",
                              textScaleFactor: 1.2,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
                return SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocProvider.of<AuthenticationBloc>(context)
                                    .state
                                    .user!
                                    .img ==
                                null
                            ? Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 50),
                                  width: 200,
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset("assets/icon/man.jpg"),
                                  ),
                                ),
                              )
                            : Container(
                                width: 200,
                                height: 200,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    color: Colors.grey[350],
                                    child: ExtendedImage.network(
                                      "https://banban-hr.com/hotel/public/${BlocProvider.of<AuthenticationBloc>(context).state.user!.img!}",
                                      // err: Container(
                                      //   child: Image.asset("assets/img/store/shop-hint.jpg"),
                                      // ),
                                      cacheWidth: 1000,
                                      // cacheHeight: 400,
                                      enableMemoryCache: true,
                                      clearMemoryCacheWhenDispose: true,
                                      clearMemoryCacheIfFailed: false,
                                      fit: BoxFit.fill,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                              ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "${AppLocalizations.of(context)!.translate("present")!}",
                            textScaleFactor: 1.6,
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              "${AppLocalizations.of(context)!.translate("date")!} ${checkindate!}",
                              textScaleFactor: 1.2,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else if (state is ErrorFethchingAccount) {
                return Scaffold(
                  body: Center(
                    child: TextButton(
                  onPressed: () {
                    attendanceBloc.add(FetchCheckAccountStarted(todayDate: checkindate!.substring(0, 10)));
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.teal,
                    onSurface: Colors.grey,
                  ),
                  child: Text(
                      "${AppLocalizations.of(context)!.translate("retry")!}")),
                  ),
                );
                // ignore: unnecessary_statements
              }
              return Center(
                // child: CircularProgressIndicator(),
                child: Lottie.asset('assets/animation/loader.json',
                    width: 200, height: 200),
              );
            },
            listener: (context, state) {}));
  }

  Widget checkin({required AccountModel accountModel}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            String mylat = lat.toString();
            String mylong = lot.toString();
            print("mylat $mylat");
            print("my lon $mylong");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (con) => CheckinPage(
                          lat: mylat,
                          lon: mylong,
                          // locationId: accountModel.departmentModel.loationId!,
                        )));
          },
          child: Center(
            child: Container(
              width: (MediaQuery.of(context).size.width / 10) * 4.5,
              height: (MediaQuery.of(context).size.width / 10) * 4.5,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).primaryColor.withOpacity(0.3)),
              child: Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Theme.of(context).primaryColor),
                child: Image(
                  image: AssetImage("assets/icon/qr-code.png"),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(
          "${AppLocalizations.of(context)!.translate("checkin_tap")!}",
          style: Theme.of(context).textTheme.headline6,
        )
      ],
    );
  }

  Widget checkOut({required AccountModel accountModel}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            String mylat = lat.toString();
            String mylong = lot.toString();
            print("mylat $mylat");
            print("my lon $mylong");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (con) => CheckoutPage(
                          lat: mylat,
                          lon: mylong,
                          id: accountModel.checkinId!,
                        )));
            print("hi");
          },
          child: Center(
            child: Container(
              width: (MediaQuery.of(context).size.width / 10) * 4.5,
              height: (MediaQuery.of(context).size.width / 10) * 4.5,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).primaryColor.withOpacity(0.3)),
              child: Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red),
                child: Image(
                  image: AssetImage("assets/icon/qr-code.png"),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(
          "${AppLocalizations.of(context)!.translate("checkout_tap")!}",
          style: Theme.of(context).textTheme.headline6,
        )
      ],
    );
  }
}
