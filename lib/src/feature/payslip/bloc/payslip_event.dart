import 'package:equatable/equatable.dart';

class PayslipEvent extends Equatable {
  PayslipEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitailizePayslipStarted extends PayslipEvent {
  final String? dateRange;
   final bool? isSecond;
  final String? isRefresh;
  InitailizePayslipStarted({required this.dateRange,this.isSecond, this.isRefresh});
}

class FetchPayslipStarted extends PayslipEvent {
  final String? dateRange;
  FetchPayslipStarted({required this.dateRange});
}



