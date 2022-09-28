import 'package:equatable/equatable.dart';

class SubstypeEvent extends Equatable {
  SubstypeEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchSubtypeStarted extends SubstypeEvent {
  final String id;
  FetchSubtypeStarted({required this.id});
}
