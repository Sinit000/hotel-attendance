import 'package:equatable/equatable.dart';

abstract class CheckInOutEvent extends Equatable {
  CheckInOutEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class InitializeCheckinStarted extends CheckInOutEvent{}
class FetchCheckinStarted extends CheckInOutEvent{}

class RefreshCheckinStarted extends CheckInOutEvent{}
class AddCheckinStarted extends CheckInOutEvent {
  final String checkinTime;
  final String lat;
  final String lon;
  final String locationId;
  final String date;
  final String timetableId;
  AddCheckinStarted(
      {required this.checkinTime,
      required this.lat,
      required this.lon,
      required this.locationId,
      required this.date,
      required this.timetableId});
}

class AddCheckoutStarted extends CheckInOutEvent {
  final String checkoutTime;
  final String lat;
  final String lon;
  final String locationId;
  final String date;
  final String timetableId;
  AddCheckoutStarted(
      {required this.checkoutTime,
      required this.lat,
      required this.lon,
      required this.locationId,
      required this.date,
      required this.timetableId});
}

