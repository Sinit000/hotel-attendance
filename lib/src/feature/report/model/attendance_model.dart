class AttendanceModel {
  final String id;
  final String? checkinTime;
  final String? checkoutTime;
  final String? checkinLate;
  final String? checkoutLate;
  final String? checkitStatus;
  final String? checkoutStatus;
  final String? date;
  final String? status;
  final String? noted;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
        id: json["id"].toString(),
        checkinTime: json["checkin_time"],
        checkoutTime: json["checkout_time"],
        checkinLate: json["checkin_late"],
        checkoutLate: json["checkout_late"],
        checkitStatus: json["checkin_status"],
        checkoutStatus: json["checkout_status"],
        date: json["date"],
        status: json["status"],
        noted: json["note"]);
  }
  AttendanceModel(
      {required this.id,
      required this.checkinTime,
      required this.checkoutTime,
      required this.checkinLate,
      required this.checkoutLate,
      required this.checkitStatus,
      required this.checkoutStatus,
      required this.date,
      required this.status,
      required this.noted});
}
