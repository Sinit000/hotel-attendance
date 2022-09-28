class CounterModel {
  final String id;
  final String otDuration;
  final String totalPh;
  final String hospitalLeave;
  final String marriageLeave;
  final String peternityLeave;
  final String meternityLeave;
  final String funeralLeave;
  factory CounterModel.fromJson(Map<String, dynamic> json) {
    return CounterModel(
        id: json["id"].toString(),
        otDuration: json["ot_duration"].toString(),
        totalPh: json["total_ph"].toString(),
        hospitalLeave: json["hospitality_leave"].toString(),
        marriageLeave: json["marriage_leave"].toString(),
        peternityLeave: json["peternity_leave"].toString(),
        meternityLeave: json["funeral_leave"].toString(),
        funeralLeave: json["maternity_leave"].toString());
  }
  CounterModel(
      {required this.id,
      required this.otDuration,
      required this.totalPh,
      required this.hospitalLeave,
      required this.marriageLeave,
      required this.peternityLeave,
      required this.meternityLeave,
      required this.funeralLeave});
}
