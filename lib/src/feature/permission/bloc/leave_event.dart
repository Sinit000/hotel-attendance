import 'dart:io';

import 'package:equatable/equatable.dart';

class LeaveEvent extends Equatable {
  LeaveEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchLeaveTypeStarted extends LeaveEvent {}

class InitializeLeaveStarted extends LeaveEvent {
  final String? dateRange;
  final bool? isSecond;
  final String? isRefresh;
  InitializeLeaveStarted(
      {required this.dateRange, this.isSecond, this.isRefresh});
}

class FetchLeaveStarted extends LeaveEvent {
  final String? dateRange;
  FetchLeaveStarted({required this.dateRange});
}


class InitializeAllLeaveStarted extends LeaveEvent {
  final String? dateRange;
  final bool? isSecond;
  final String? isRefresh;
  InitializeAllLeaveStarted(
      {required this.dateRange, this.isSecond, this.isRefresh});
}

class FetchAllLeaveStarted extends LeaveEvent {
  final String? dateRange;
  FetchAllLeaveStarted({required this.dateRange});
}



class AddLeaveStarted extends LeaveEvent {
  // final String employeeId;
  final String leaveTypeId;
  final String reason;
  final String number;
  final String fromDate;
  final String toDate;
  final String type;
  final File? imgUrl;

  final String createdDate;
  final String today;
  final String? notes;
  AddLeaveStarted({
    required this.type,
    required this.leaveTypeId,
    required this.reason,
    required this.number,
    required this.fromDate,
    required this.toDate,
    required this.imgUrl,
    required this.notes,
    required this.createdDate,
    required this.today,
  });
}

class UpdateLeaveStarted extends LeaveEvent {
  final String id;
  final String leaveTypeId;
  final String reason;
  final String number;
  final String fromDate;
  final String toDate;
  final String type;
  final File? imgUrl;
  // final String? subtype;
  final String? notes;
  final String? imageUrl;
  final String createdDate;
  final String today;
  UpdateLeaveStarted(
      {required this.id,
      required this.type,
      required this.leaveTypeId,
      required this.reason,
      required this.number,
      required this.fromDate,
      required this.toDate,
      required this.imgUrl,
      required this.notes,
      required this.createdDate,
      required this.today,
      required this.imageUrl});
}

class UpdateLeaveStatusStarted extends LeaveEvent {
  final String id;
  final String status;
  final String leaveDeduction;
  UpdateLeaveStatusStarted(
      {required this.id, required this.status, required this.leaveDeduction});
}

class DeleteLeaveStarted extends LeaveEvent {
  final String id;
  // final String date;
  DeleteLeaveStarted({
    required this.id,
  });
}
