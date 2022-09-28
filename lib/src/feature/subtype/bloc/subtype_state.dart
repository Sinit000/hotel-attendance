import 'package:equatable/equatable.dart';

class SubstypeState extends Equatable {
  SubstypeState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchingSubtype extends SubstypeState {}

class FetchedSubtype extends SubstypeState {
  final int? length;
  FetchedSubtype({required this.length});
}

class ErrorFetchingSubtype extends SubstypeState {
  final dynamic error;
  ErrorFetchingSubtype({required this.error});
}
