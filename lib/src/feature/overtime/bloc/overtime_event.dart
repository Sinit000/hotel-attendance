import 'package:equatable/equatable.dart';

class OverTimeEvent extends Equatable {
  OverTimeEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitailzeMyOvertimeStarted extends OverTimeEvent {
  final String? dateRange;
  final bool? isSecond;
  final String? isRefresh;
  InitailzeMyOvertimeStarted(
      {required this.dateRange, this.isSecond, this.isRefresh});
}

class InitializeAllOvertimeStarted extends OverTimeEvent {
  final String? dateRange;
  final bool? isSecond;
  final String? isRefresh;
  InitializeAllOvertimeStarted(
      {required this.dateRange, this.isSecond, this.isRefresh});
}

class FetchMyOvertimeStarted extends OverTimeEvent {
  final String? dateRange;
  FetchMyOvertimeStarted({required this.dateRange});
}

class FetchAllOvertimeStarted extends OverTimeEvent {
  final String? dateRange;
  FetchAllOvertimeStarted({required this.dateRange});
}

// class RefreshMyOvertimeStarted extends OverTimeEvent {
//   final String? dateRange;
//   RefreshMyOvertimeStarted({required this.dateRange});
// }

// class RefreshAllOvertimeStarted extends OverTimeEvent {
//   final String? dateRange;
//   RefreshAllOvertimeStarted({required this.dateRange});
// }

class AddOvertimeStarted extends OverTimeEvent {
  final String userId;
  final String fromDate;
  final String toDate;
  final String notes;
  final String reason;
  final String type;
  final String otMethod;
  final String duration;
  final String createdDate;
  final String today;
  AddOvertimeStarted({
    required this.userId,
    required this.fromDate,
    required this.toDate,
    required this.notes,
    required this.reason,
    required this.type,
    required this.otMethod,
    required this.duration,
    required this.createdDate,
    required this.today,
  });
}

class UpdateOvertimeStarted extends OverTimeEvent {
  final String id;
  final String userId;
  final String fromDate;
  final String toDate;
  final String notes;
  final String reason;
  final String type;
  final String otMethod;
  final String duration;
  final String createdDate;
  final String today;
  UpdateOvertimeStarted({
    required this.userId,
    required this.fromDate,
    required this.toDate,
    required this.notes,
    required this.reason,
    required this.id,
    required this.type,
    required this.otMethod,
    required this.duration,
    required this.createdDate,
    required this.today,
  });
}

class UpdateOvertimeStatusStarted extends OverTimeEvent {
  final String id;
  final String status;
  final String paytype;
  UpdateOvertimeStatusStarted(
      {required this.id, required this.status, required this.paytype});
}

class DeleteOvertimeStarted extends OverTimeEvent {
  final String id;
  DeleteOvertimeStarted({
    required this.id,
  });
}
