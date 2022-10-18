class NotificationModel {
  final String id;
  final String comment;

  final String? date;
  final String? userId;
  // final String? targetValue;
  final String title;
  final String? time;
  final String? createDate;

  NotificationModel(
      {required this.id,
      required this.comment,
      required this.userId,
      required this.date,
      required this.createDate,
      required this.time,
      required this.title});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        id: json['id'].toString(),
        comment: json["body"],
        date: json['date'],
        userId: json['user_id'].toString(),
        createDate: json['created_at'].toString(),
        time: json["time"].toString(),
        title: json["title"]);
  }
}
