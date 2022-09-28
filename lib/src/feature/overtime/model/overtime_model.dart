class OvertimeModel {
  final String id;
  final String? userId;
  final String? reason;
  final String? name;
  final String? date;
  final String? fromDate;
  final String? toDate;
  final String? duration;
  final String? status;
  final String? paytype;
  final String? type;
  final String? notes;
  final String? otRate;
  final String? otHour;
  final String? otMethod;
  final String? totalOt;
  final String? payStatus;
  final String? requestBy;
  factory OvertimeModel.fromJson(Map<String, dynamic> json) {
    return OvertimeModel(
      id: json["id"].toString(),
      name: json["name"],
      duration: json["number"],
      fromDate: json["from_date"],
      toDate: json["to_date"],
      status: json["status"],
      notes: json["notes"],
      userId: json["user_id"].toString(),
      type: json["type"],
      paytype: json["pay_type"],
      reason: json["reason"],
      date: json["date"],
      payStatus: json["pay_status"],
      otRate: json["ot_rate"].toString(),
      otHour: json["ot_hour"].toString(),
      otMethod: json["ot_method"].toString(),
      requestBy: json["requested_by"],
      totalOt: json["total_ot"].toString(),
    );
  }
  OvertimeModel(
      {required this.id,
      required this.name,
      required this.duration,
      required this.fromDate,
      required this.toDate,
      required this.status,
      required this.notes,
      required this.userId,
      required this.type,
      required this.paytype,
      required this.reason,
      required this.date,
      required this.otRate,
      required this.otHour,
      required this.otMethod,
      required this.payStatus,
      required this.requestBy,
      required this.totalOt});
}
