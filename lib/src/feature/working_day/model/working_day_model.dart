class WorkdayModel {
  final String id;
  final String name;
  final String workDay;
  final String? offDay;
  final String? notes;
  final String? typeDatetime;
  final String? dateTime;
  factory WorkdayModel.fromJson(Map<String, dynamic> json) {
    return WorkdayModel(
        id: json["id"].toString(),
        name: json["name"],
        workDay: json["working_day"],
        offDay: json["off_day"],
        notes: json["notes"],
        typeDatetime: json["type_date_time"],
        dateTime: json["date_time"]);
  }
  WorkdayModel(
      {required this.id,
      required this.name,
      required this.workDay,
      required this.offDay,
      required this.notes,
      required this.typeDatetime,
      required this.dateTime});
}
