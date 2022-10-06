import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

// import 'package:flutter_switch/flutter_switch.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:location/location.dart';

class NearbyDriver extends StatefulWidget {
  // final UserModel userModel;
  // const NearbyDriver({Key key, @required this.userModel}) : super(key: key);
  @override
  NearbyDriverState createState() => NearbyDriverState();
}

class NearbyDriverState extends State<NearbyDriver> {
  // String mylat = "Connecting...";
  // String driveronline = "Driver is online";
  // String driveroffline = "Driver is offline";
  // static bool isOnline = false;

  // static PusherClient pusher;
  // static Channel channel;
  // Channel channel2;
  // Completer<GoogleMapController> _controller = Completer();
  // Set<Marker> _marker = HashSet<Marker>();
  // Set<Polyline> _polylines = Set<Polyline>();
  double? lat;
  double? lot;
  PermissionStatus? _permissionGranted;
  LocationData? _location;
  final Location location = Location();
  static StreamSubscription<LocationData>? locationSubscription;
  String? _error;
  String? userName;

  // GoogleMapController? mapController;
  // LatLng? _initialcameraposition;
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

  // Future<bool> locationDialog() {
  //   return showDialog(
  //           context: context,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //               title: Text('សូមបើកទីតាំងរបស់អ្នក !'),
  //               content: Text('សូមបើកទីតាំងរបស់អ្នក'),
  //               actions: <Widget>[
  //                 FlatButton(
  //                   onPressed: () {
  //                     AppSettings.openLocationSettings();
  //                   },
  //                   child: Text('OK'),
  //                 ),
  //               ],
  //             );
  //           }) ??
  //       false;
  // }

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
        _myLocation();
      } else {
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

  // Future<void> _listenLocation() async {
  //   location.changeSettings(interval: 100000);
  //   locationSubscription =
  //       location.onLocationChanged.handleError((dynamic err) {
  //     setState(() {
  //       _error = err.code;
  //     });
  //     locationSubscription.cancel();
  //   }).listen((LocationData currentLocation) {
  //     _error = null;
  //     _location = currentLocation;
  //     mylat = _location.latitude.toString();
  //     // if (mylat == _location.latitude.toString()) {
  //     //   isOnline = true;
  //     // } else {
  //     //   isOnline = false;
  //     // }
  //     // _goCurrentLocation(_location.latitude, _location.longitude);
  //     if (isOnline == true) {
  //       channel.trigger('event', {
  //         "user": {
  //           "id": widget.userModel.id.toString(),
  //           "name": widget.userModel.name,
  //           "phone": widget.userModel.phone,
  //           "email": widget.userModel.email
  //         },
  //         "lat": _location.latitude,
  //         "lng": _location.longitude,
  //       });
  //       print(_location.latitude);
  //       print(_location.longitude);
  //       print(widget.userModel.name);
  //     }
  //     // else {
  //     //   channel.trigger('event', {
  //     //     "user": {
  //     //       "id": widget.userModel.id.toString(),
  //     //       "name": widget.userModel.name,
  //     //       "phone": widget.userModel.phone,
  //     //       "email": widget.userModel.email
  //     //     },
  //     //     "lat": "",
  //     //     "lng": "",
  //     //   });
  //     //   print(_location.latitude);
  //     //   print(_location.longitude);
  //     //   print(widget.userModel.name);
  //     // }
  //   });
  // }

  // Future<void> postDataToServer() async {
  //   pusher = new PusherClient(
  //     "d55f4e6426924d8921a1",
  //     PusherOptions(
  //         // if local on android use 10.0.2.2
  //         cluster: "ap1",
  //         encrypted: true,
  //         auth: PusherAuth(
  //             'https://delivery.anakutapp.com/driver/public/broadcasting/auth',
  //             headers: {
  //               "Authorization": "Bearer " + widget.userModel.token,
  //             })),
  //     enableLogging: true,
  //   );
  // }

  @override
  void initState() {
    super.initState();
    // _myLocation();
    // BlocProvider.of<IsOnlineBloc>(context).add(IsOnline(isOnline: isOnline));
    // postDataToServer();
    // channel = pusher.subscribe("private-chat");
    // // channel2 = pusher.subscribe("DemoChannel");

    // pusher.onConnectionStateChange((state) {
    //   log("previousState: ${state.previousState}, currentState: ${state.currentState}");
    // });

    // pusher.onConnectionError((error) {
    //   log("error: ${error.message}");
    // });
    // channel2.bind('WebsocketDemoEvent', (event) {
    //   log("" + event.data.toString());
    // });
    // channel.bind('App\\Events\\MessageSent', (event) {
    //   BlocProvider.of<PickUpBloc>(context).add(PickUpCame(
    //       pickupInformation:
    //           PickupInformation.fromJson(json.decode(event.data))));
    // });

    // channel.bind('pusher:subscription_succeeded', (event) {
    //   log("" + event.data.toString());
    // });
    // channel.bind('client-event', (event) {
    //   print(event.data);
    // });
    // channel.bind('client-pickup', (event) {
    //   print(event.data);
    // });
    // channel.bind('pickup', (event) {
    //   BlocProvider.of<PickUpBloc>(context).add(PickUpCame(
    //       pickupInformation:
    //           PickupInformation.fromJson(jsonDecode(event.data))));
    // });

    _checkPermissions();
    _requestPermission();
    // _listenLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test lat and long"),
      ),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.lightBlueAccent,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {}),
      ),
      body: Container(
        child: Column(
          children: [
            Text("lat $lat"),
            Text("long $lot"),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // locationSubscription.cancel();
    // channel.cancelEventChannelStream();
    super.dispose();
  }
  // Future<void> _goCurrentLocation(double lat, double lng) async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  //   setState(() {
  //     _marker.add(Marker(markerId: MarkerId("d"), position: LatLng(lat, lng)));
  //   });
  // }
}
