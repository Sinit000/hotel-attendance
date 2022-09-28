class SubtypeModel {
  final String id;
  final String name;
  final String duration;
  final String leavetypeId;
  factory SubtypeModel.fromJson(Map<String, dynamic> json) {
    return SubtypeModel(
        id: json["id"].toString(),
        name: json["name"],
        duration: json["duration"].toString(),
        leavetypeId: json["leave_type_id"].toString());
  }
  SubtypeModel(
      {required this.id,
      required this.name,
      required this.duration,
      required this.leavetypeId});
}
