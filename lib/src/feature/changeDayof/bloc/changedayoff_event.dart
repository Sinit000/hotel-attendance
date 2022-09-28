import 'package:equatable/equatable.dart';

class ChangeDayOffEvent extends Equatable {
  ChangeDayOffEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

// class FetchLeaveTypeStarted extends LeaveOutEvent {}

class InitializeMyDayOffStarted extends ChangeDayOffEvent {
  final String? dateRange;
  final bool? isSecond;
  final String? isRefresh;
  InitializeMyDayOffStarted(
      {required this.dateRange, this.isSecond, this.isRefresh});
}

class FetchMyDayOffStarted extends ChangeDayOffEvent {
  final String? dateRange;
  final bool? isSecond;
  final String? isRefresh;
  FetchMyDayOffStarted(
      {required this.dateRange, this.isSecond, this.isRefresh});
}

class InitializeAllDayOffStarted extends ChangeDayOffEvent {
  final String? dateRange;
  final bool? isSecond;
  final String? isRefresh;
  InitializeAllDayOffStarted(
      {required this.dateRange, this.isSecond, this.isRefresh});
}

class FetchAllDayOffStarted extends ChangeDayOffEvent {
  final String? dateRange;
  final bool? isSecond;
  final String? isRefresh;
  FetchAllDayOffStarted(
      {required this.dateRange, this.isSecond, this.isRefresh});
}

// class RefreshAllDayOffStarted extends ChangeDayOffEvent {
//   final String? dateRange;
//   RefreshAllDayOffStarted({required this.dateRange});
// }

class AddDayOffStarted extends ChangeDayOffEvent {
  final String reason;
  final String holidayId;
  final String workdayId;
  final String fromDate;
  final String toDate;
  final String type;

  AddDayOffStarted(
      {required this.type,
      required this.holidayId,
      required this.workdayId,
      required this.reason,
      required this.fromDate,
      required this.toDate});
}

class UpdateDayOffStarted extends ChangeDayOffEvent {
  final String id;
  final String reason;
  final String holidayId;
  final String workdayId;
  final String fromDate;
  final String toDate;
  final String type;
  UpdateDayOffStarted(
      {required this.id,
      required this.type,
      required this.holidayId,
      required this.workdayId,
      required this.reason,
      required this.fromDate,
      required this.toDate});
}

class UpdateDayOffStatusStarted extends ChangeDayOffEvent {
  final String id;
  final String status;
  UpdateDayOffStatusStarted({required this.id, required this.status});
}

class DeleteDayOffStarted extends ChangeDayOffEvent {
  final String id;
  // final String date;
  DeleteDayOffStarted({
    required this.id,
  });
}
