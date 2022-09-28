import 'package:equatable/equatable.dart';

class ReportEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchReportStarted extends ReportEvent {
  final String? dateRange;
  FetchReportStarted({required this.dateRange});
}

class InitailizeReportStarted extends ReportEvent {
  final String? dateRange;
  final bool? isSecond;
  final String? isRefresh;
  InitailizeReportStarted({required this.dateRange,this.isSecond,this.isRefresh});
}

class RefreshReportStarted extends ReportEvent {
  final String? dateRange;
  RefreshReportStarted({required this.dateRange});
}
