import 'package:equatable/equatable.dart';

class ReportEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchReportStarted extends ReportEvent {
  final String? dateRange;
  FetchReportStarted({required this.dateRange});
}

class InitailizeAttendanceStarted extends ReportEvent {
  final String? dateRange;
  final bool? isSecond;
  final String? isRefresh;
  InitailizeAttendanceStarted(
      {required this.dateRange, this.isSecond, this.isRefresh});
}

class FetchAttendanceStarted extends ReportEvent {
  final String? dateRange;
  FetchAttendanceStarted({required this.dateRange});
}

class RefreshReportStarted extends ReportEvent {
  final String? dateRange;
  RefreshReportStarted({required this.dateRange});
}
