class ReportModel {
  final String attendance;
  final String leave;
  final String leaveDeduction;
  final String leaveout;
  final String totalOt;
  final String otCash;
  final String otHour;
  final String absent;
  final String holiday;
  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
        attendance: json["attendance"].toString(),
        leave: json["leave"].toString(),
        leaveDeduction: json["leave_duction"].toString(),
        leaveout: json["leaveout"].toString(),
        totalOt: json["total_ot"].toString(),
        otCash: json["ot_cash"].toString(),
        absent:json["absent"].toString(),
        holiday: json["ot_holiday"].toString(),
        otHour: json["ot_hour"].toString());
  }
  ReportModel(
      {required this.attendance,
      required this.leave,
      required this.leaveDeduction,
      required this.leaveout,
      required this.totalOt,
      required this.otCash,
      required this.absent,
      required this.holiday,
      required this.otHour});
}
