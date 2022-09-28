class CheckinModel {
  final String? id;
  final String? date;
  final String? checkinTime;
  final String? checkoutTime;
  final String? checkinLate;
  final String? checkoutOver;
  final String? checkinStatus;
  final String? checkoutStatus;
  factory CheckinModel.fromJson(Map<String, dynamic> json) {
    return CheckinModel(
        id: json["id"].toString(),
        date: json["date"],
        checkinTime: json["checkin_time"],
        checkoutTime: json["checkout_time"],
        checkinLate: json["checkin_late"],
        checkoutOver: json["checkout_late"],
        checkinStatus: json["checkin_status"],
        checkoutStatus: json["checkout_status"]);
  }
  CheckinModel(
      {required this.id,
      required this.date,
      required this.checkinTime,
      required this.checkoutTime,
      required this.checkinLate,
      required this.checkoutOver,
      required this.checkinStatus,
      required this.checkoutStatus});
}
