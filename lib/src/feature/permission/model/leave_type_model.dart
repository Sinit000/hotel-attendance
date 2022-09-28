class LeaveTypeModel {
  final String id;
  final String leaveType;
  final String duration;
  final String parentId;
  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) {
    return LeaveTypeModel(
        id: json['id'].toString(),
        duration: json["duration"].toString(),
        parentId: json["parent_id"].toString(),
        leaveType: json['leave_type']);
  }
  LeaveTypeModel(
      {required this.id,
      required this.leaveType,
      required this.duration,
      required this.parentId});
}
