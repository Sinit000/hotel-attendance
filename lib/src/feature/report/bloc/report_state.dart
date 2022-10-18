import 'package:equatable/equatable.dart';

class ReportState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitializingReport extends ReportState {}

class InitializedReport extends ReportState {}

class EndOfReportlist extends ReportState{}

class FetchingReport extends ReportState {}

class FetchedReport extends ReportState {}

class EndOfReportList extends ReportState {}

class ErrorFetchingReport extends ReportState {
  final dynamic error;
  ErrorFetchingReport({required this.error});
}
