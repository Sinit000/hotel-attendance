import 'package:equatable/equatable.dart';

class OTCompesationEvent extends Equatable {
  OTCompesationEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitailzeOTCompesationStarted extends OTCompesationEvent {
  final String? dateRange;
  final bool? isSecond;
  final bool? isRefresh;
  InitailzeOTCompesationStarted(
      {required this.dateRange,
      required this.isRefresh,
      required this.isSecond});
}

// class InitializeOTCompesationStarted extends OTCompesationEvent {
//   final String? dateRange;
//   InitializeOTCompesationStarted({required this.dateRange});
// }

class FetchOTCompesationStarted extends OTCompesationEvent {
  final String? dateRange;
  FetchOTCompesationStarted({required this.dateRange});
}

class FetchAllOTCompestaionStarted extends OTCompesationEvent {
  final String? dateRange;
  FetchAllOTCompestaionStarted({required this.dateRange});
}

// class RefreshMyOTCompesationStarted extends OTCompesationEvent {
//   final String? dateRange;
//   RefreshMyOTCompesationStarted({required this.dateRange});
// }

// class RefreshAllOTCompesationStarted extends OTCompesationEvent {
//   final String? dateRange;
//   RefreshAllOTCompesationStarted({required this.dateRange});
// }

class AddOTCompesationStarted extends OTCompesationEvent {
  final String fromDate;
  final String toDate;

  final String reason;
  final String type;
  final String createdDate;
  final String today;
  final String duration;
  AddOTCompesationStarted({
    required this.fromDate,
    required this.toDate,
    required this.reason,
    required this.type,
    required this.createdDate,
    required this.today,
    required this.duration,
  });
}

class UpdateOTCompesationStarted extends OTCompesationEvent {
  final String id;

  final String fromDate;
  final String toDate;

  final String reason;
  final String type;
  final String createdDate;
  final String today;
  final String duration;
  UpdateOTCompesationStarted({
    required this.createdDate,
    required this.today,
    required this.fromDate,
    required this.toDate,
    required this.reason,
    required this.id,
    required this.type,
    required this.duration,
  });
}

// class UpdateOvertimeStatusStarted extends OTCompesationEvent {
//   final String id;
//   final String status;
//   final String paytype;
//   UpdateOvertimeStatusStarted(
//       {required this.id, required this.status, required this.paytype});
// }

class DeleteOTCompesationStarted extends OTCompesationEvent {
  final String id;
  DeleteOTCompesationStarted({
    required this.id,
  });
}
// song mong

class InitailzeSongMongStarted extends OTCompesationEvent {
  final String? dateRange;
  final bool? isSecond;
  final bool? isRefresh;
  InitailzeSongMongStarted(
      {required this.dateRange,
      required this.isRefresh,
      required this.isSecond});
}

class FetchSongMonStarted extends OTCompesationEvent {
  final String? dateRange;

  FetchSongMonStarted({required this.dateRange});
}

class AddSongMongStarted extends OTCompesationEvent {
  final String fromDate;
  final String toDate;
  final String createdDate;
  final String date;
  AddSongMongStarted(
      {required this.fromDate,
      required this.toDate,
      required this.createdDate,
      required this.date});
}

class UpdateSongMongStarted extends OTCompesationEvent {
  final String id;
  final String fromDate;
  final String toDate;
  final String createdDate;
  final String date;
  UpdateSongMongStarted(
      {required this.id,
      required this.fromDate,
      required this.toDate,
      required this.createdDate,
      required this.date});
}

class DeleteSongMongStarted extends OTCompesationEvent {
  final String id;

  DeleteSongMongStarted({
    required this.id,
  });
}
