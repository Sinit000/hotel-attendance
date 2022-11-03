import 'dart:io';

import 'package:equatable/equatable.dart';

class LeaveOutEvent extends Equatable {
  LeaveOutEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitializeMyLeaveOutStarted extends LeaveOutEvent {
  final String? dateRange;
  final bool? isSecond;
  final String? isRefresh;
  InitializeMyLeaveOutStarted(
      {required this.dateRange, this.isSecond, this.isRefresh});
}

class FetchMyLeaveOutStarted extends LeaveOutEvent {
  final String? dateRange;

  FetchMyLeaveOutStarted({required this.dateRange});
}

class InitializeAllLeaveOutStarted extends LeaveOutEvent {
  final String? dateRange;
  final bool? isSecond;
  final String? isRefresh;
  InitializeAllLeaveOutStarted(
      {required this.dateRange, this.isSecond, this.isRefresh});
}

class FetchAllLeaveOutStarted extends LeaveOutEvent {
  final String? dateRange;
  FetchAllLeaveOutStarted({required this.dateRange});
}

// for security
class InitializeLeaveOutSecurityStarted extends LeaveOutEvent {
  final String? dateRange;
  final bool? isSecond;
  final String? isRefresh;
  InitializeLeaveOutSecurityStarted(
      {required this.dateRange, this.isSecond, this.isRefresh});
}

class FetchLeaveOutSecurityStarted extends LeaveOutEvent {
  final String? dateRange;
  FetchLeaveOutSecurityStarted({required this.dateRange});
}

class AddLeaveOutStarted extends LeaveOutEvent {
  final String reason;
  final String requestType;
  final String timein;
  final String timeout;
  final String createdDate;
  final String today;
  final String note;
  AddLeaveOutStarted(
      {required this.createdDate,
      required this.today,
      required this.reason,
      required this.timein,
      required this.timeout,
      required this.note,
      required this.requestType});
}

class UpdateLeaveOutStarted extends LeaveOutEvent {
  final String id;
  final String reason;
  final String requestType;

  final String timein;
  final String timeout;
  final String createdDate;
  final String today;
  final String note;

  UpdateLeaveOutStarted(
      {required this.id,
      required this.createdDate,
      required this.today,
      required this.reason,
      required this.timein,
      required this.timeout,
      required this.note,
      required this.requestType});
}

class UpdateLeaveOutStatusStarted extends LeaveOutEvent {
  final String id;
  final String status;
  // final String requestType;
  UpdateLeaveOutStatusStarted({required this.id, required this.status});
}

class UpdateLeaveOutSStatusStarted extends LeaveOutEvent {
  final String id;
  final String status;
  final String arrivingTime;
  UpdateLeaveOutSStatusStarted(
      {required this.id, required this.status, required this.arrivingTime});
}

class DeleteLeaveOutStarted extends LeaveOutEvent {
  final String id;
  // final String date;
  DeleteLeaveOutStarted({
    required this.id,
  });
}
