import 'package:equatable/equatable.dart';

class LeaveState extends Equatable {
  LeaveState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitializingLeave extends LeaveState {}

class InitializedLeave extends LeaveState {}

class FetchingLeave extends LeaveState {}

class FetchedLeave extends LeaveState {}

class FetchingLeaveType extends LeaveState {}

class FetchedLeaveType extends LeaveState {}

class EndOfLeaveList extends LeaveState {}

class ErrorFetchingLeaveType extends LeaveState {
  final dynamic error;
  ErrorFetchingLeaveType({required this.error});
}

class ErrorFetchingLeave extends LeaveState {
  final dynamic error;
  ErrorFetchingLeave({required this.error});
}

class AddingLeave extends LeaveState {}

class AddedLeave extends LeaveState {}

class ErrorAddingLeave extends LeaveState {
  final dynamic error;
  ErrorAddingLeave({required this.error});
}
