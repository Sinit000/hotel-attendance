import 'package:equatable/equatable.dart';

class TimetableState extends Equatable {
  TimetableState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchingTime extends TimetableState{}

class FetchedTime extends TimetableState{}

class ErrorFetchingTime extends TimetableState{
  final String error;
  ErrorFetchingTime({
    required this.error
  });
}