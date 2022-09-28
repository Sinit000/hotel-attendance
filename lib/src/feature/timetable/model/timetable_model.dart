class TimetableModel {
  final String id;
  final String timetableName;
  final String onDutyTtime;
  final String offDutyTime;
  factory TimetableModel.fromJson(Map<String, dynamic> json) {
    return TimetableModel(
        id: json["id"].toString(),
        timetableName: json["timetable_name"],
        offDutyTime: json["off_duty_time"],
        onDutyTtime: json["on_duty_time"]);
  }
  TimetableModel(
      {required this.id,
      required this.timetableName,
      required this.offDutyTime,
      required this.onDutyTtime});
}