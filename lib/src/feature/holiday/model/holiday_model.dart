class HolidayModel {
  final String id;
  final String name;
  final String? fromDate;
  final String? toDate;
  final String? notes;
  final String? status;
  final String? duration;

  factory HolidayModel.fromJson(Map<String, dynamic> json) {
    return HolidayModel(
        id: json["id"].toString(),
        name: json["name"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        notes: json["notes"],
        status: json["status"],
        duration: json["duration"].toString());
  }

  HolidayModel(
      {required this.id,
      required this.name,
      required this.fromDate,
      required this.toDate,
      required this.notes,
      required this.status,
      required this.duration});
}
