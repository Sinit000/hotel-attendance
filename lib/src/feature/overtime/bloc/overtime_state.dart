import 'package:equatable/equatable.dart';

class OverTimeState extends Equatable {
  OverTimeState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitailizingOvertime extends OverTimeState {}

class InitailizedOvertime extends OverTimeState {}

class FetchingOvertime extends OverTimeState {}

class FetchedOvertime extends OverTimeState {}

class EndofOvertimeList extends OverTimeState {}

class ErrorFetchingOvertime extends OverTimeState {
  final dynamic error;
  ErrorFetchingOvertime({required this.error});
}

class AddingOvertime extends OverTimeState {}

class AddedOvertime extends OverTimeState {}

class ErrorAddingOvertime extends OverTimeState {
  final dynamic error;
  ErrorAddingOvertime({required this.error});
}
