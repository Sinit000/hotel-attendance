import 'package:e_learning/src/feature/permission/model/leave_type_model.dart';

class LeaveModel {
  final String id;
  final String? date;
  final String? status;
  final String? fromDate;
  final String? toDate;
  final String? reason;
  final String? type;
  final String? subtype;
  final String? leavetype;
  final String? number;
  final String? note;
  final String? imgUrl;
  final String? leaveDeduction;
  final LeaveTypeModel? leaveTypeModel;
  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
        id: json["id"].toString(),
        date: json["date"],
        status: json["status"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        number: json["number"],
        reason: json["reason"],
        type: json["type"],
        leavetype: json["leave_type"],
        subtype: json["subtype"],
        imgUrl: json["image_url"],
        note: json["note"],
        leaveDeduction: json["leave_deduction"].toString(),
        leaveTypeModel: json["leavetype"] == null
            ? null
            : LeaveTypeModel.fromJson(json["leavetype"]));
  }
  LeaveModel(
      {required this.id,
      required this.date,
      required this.status,
      required this.fromDate,
      required this.toDate,
      required this.number,
      required this.reason,
      required this.note,
      required this.subtype,
      required this.leavetype,
      required this.type,
      required this.imgUrl,
      required this.leaveDeduction,
      required this.leaveTypeModel});
}
