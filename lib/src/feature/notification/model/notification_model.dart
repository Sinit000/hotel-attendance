class NotificationModel {
  final String id;
  final String comment;

  final String? date;
  final String? userId;
  // final String? targetValue;
  final String title;
  final String? time;

  NotificationModel(
      {required this.id,
      required this.comment,
      required this.userId,
      required this.date,
      // required this.targetValue,
      required this.time,
      required this.title});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        id: json['id'].toString(),
        comment: json["body"],
        date: json['date'],
        userId: json['user_id'].toString(),
        // targetValue: json['target_value'],
        time: json["time"].toString(),
        title: json["title"]);
  }
}
