import 'package:e_learning/src/feature/employee/model/employee_model.dart';
import 'package:e_learning/src/feature/permission/model/leave_type_model.dart';

class LeaveOutModel {
  final String id;
  final String? date;
  final String? status;
  final String? timein;
  final String? timeout;
  final String? reason;
  final String? checkby;
  final String? name;
  final String? approveby;
  final String? duration;
  final String? type;
  final String? requestType;
  final String? note;
  // final String? imgUrl;
  final EmployeeModel? employeeModel;
  factory LeaveOutModel.fromJson(Map<String, dynamic> json) {
    return LeaveOutModel(
        id: json["id"].toString(),
        date: json["date"],
        status: json["status"],
        timein: json["time_in"].toString(),
        timeout: json["time_out"].toString(),
        duration: json["duration"].toString(),
        reason: json["reason"],
        checkby: json["check_by"],
        approveby: json["approve_by"],
        name: json["name"],
        type: json["type"],
        note: json["note"],
        requestType: json["request_type"],
        employeeModel:
            json["user"] == null ? null : EmployeeModel.fromJson(json["user"]));
  }
  LeaveOutModel({
    required this.id,
    required this.date,
    required this.status,
    required this.timein,
    required this.timeout,
    required this.duration,
    required this.reason,
    required this.checkby,
    required this.approveby,
    required this.employeeModel,
    required this.name,
    required this.requestType,
    required this.note,
    required this.type,
  });
}
