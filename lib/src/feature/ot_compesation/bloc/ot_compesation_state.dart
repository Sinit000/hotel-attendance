import 'package:equatable/equatable.dart';

class OTCompesationState extends Equatable {
  OTCompesationState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitailizingOTCompesation extends OTCompesationState {}

class InitailizedOTCompesation extends OTCompesationState {}

class FetchingOTCompesation extends OTCompesationState {}

class FetchedOTCompesation extends OTCompesationState {}

class EndofOTCompesationList extends OTCompesationState {}

class ErrorFetchingOTCompesation extends OTCompesationState {
  final dynamic error;
  ErrorFetchingOTCompesation({required this.error});
}

class AddingOTCompesation extends OTCompesationState {}

class AddedOTCompesation extends OTCompesationState {}

class ErrorAddingOTCompesation extends OTCompesationState {
  final dynamic error;
  ErrorAddingOTCompesation({required this.error});
}

class InitailizingSongMong extends OTCompesationState {}

class InitailizedSongMong extends OTCompesationState {}

class FetchingSongMong extends OTCompesationState {}

class FetchedSongMong extends OTCompesationState {}

class ErrorAddingSongMong extends OTCompesationState {
  final dynamic error;
  ErrorAddingSongMong({required this.error});
}
class AddingSongMong extends OTCompesationState{}

class AddedSongMong extends OTCompesationState{}

class ErrorFetchingSongMong extends OTCompesationState {
  final dynamic error;
  ErrorFetchingSongMong({required this.error});
}

class EndOfSonMong extends OTCompesationState{}
