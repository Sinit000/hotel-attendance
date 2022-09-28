class EmployeeModel {
  final String? id;
  final String? username;
  final String? name;
  final String? nationalilty;
  final String? dob;
  final String? email;
  final String? phone;
  final String? address;
  final String? img;
  final String? officeTel;
  final String? no;
  final String? card;
  final String? status;
  final String? leaveStatus;
  final String? checkinStatus;
  final String? checkinId;
  final String? statusLeava;
  // final String? type;
  
  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    // List<TimetableModel> time = [];
    //  json["timetable"].forEach((val) {
    //     time.add(TimetableModel.fromJson(val));
    //   });
    return EmployeeModel(
      id: json["id"].toString(),
      name: json["name"],
      status: json["status"],
      leaveStatus: json["status_leave"],
      statusLeava: json["leave_status"],
      checkinStatus: json["checkin_status"],
      checkinId: json["checkin_id"].toString(),
      username: json["username"],
      nationalilty: json["nationality"],
      dob: json["dob"],
      phone: json["employee_phone"],
      img: json["profile_url"],
      email: json["email"],
      
      address: json["address"],
      card: json["card_number"],
      officeTel: json["office_tel"],
      no: json["no"],
     

      // storeModel:
      //     json["store"] == null ? null : StoreModel.fromJson(json["store"]
      //     )

      // type: json["em_type"].toString(),
    );
  }
  EmployeeModel(
      {required this.name,
      required this.id,
      required this.status,
      required this.leaveStatus,
      required this.statusLeava,
      required this.checkinId,
      required this.checkinStatus,
      required this.username,
      required this.nationalilty,
      required this.dob,
      required this.phone,
      required this.img,
      required this.email,
     
      // required this.type,
      required this.no,
      required this.card,
      required this.officeTel,
      required this.address});
}