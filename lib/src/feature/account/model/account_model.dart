import 'package:e_learning/src/feature/timetable/model/timetable_model.dart';

class AccountModel {
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
  final String? maritalStatus;
  final String? spouseJob;
  final String? minorChild;
  final String? note;
  // final String? workdayId;
  // final String

  // final String? type;
  final TimetableModel? timetableModel;
  final DepartmentModel? departmentModel;
  final PositionModel? positionModel;
  final RoleModel? roleModel;
  final WorkdayModel? workModel;
  factory AccountModel.fromJson(Map<String, dynamic> json) {
    // List<TimetableModel> time = [];
    // if (json["timetable"] != null) {
    //   json["timetable"].forEach((val) {
    //     time.add(TimetableModel.fromJson(val));
    //   });
    // }

    return AccountModel(
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
      timetableModel: json["timetable"] == null
          ? null
          : TimetableModel.fromJson(json["timetable"]),
      address: json["address"],
      card: json["card_number"],
      officeTel: json["office_tel"],
      no: json["no"],
      maritalStatus: json["merital_status"],
      minorChild: json["minor_children"].toString(),
      spouseJob: json["spouse_job"].toString(),
      note: json["note"],
      roleModel: json["role"] == null ? null : RoleModel.fromJson(json["role"]),
      departmentModel: json["department"] == null
          ? null
          : DepartmentModel.fromJson(json["department"]),
      workModel: json["workday"] == null
          ? null
          : WorkdayModel.fromJson(json["workday"]),
      positionModel: json["position"] == null
          ? null
          : PositionModel.fromJson(json["position"]),

      // storeModel:
      //     json["store"] == null ? null : StoreModel.fromJson(json["store"]
      //     )

      // type: json["em_type"].toString(),
    );
  }
  // final StoreModel? storeModel;
  // final String email;
  AccountModel(
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
      required this.timetableModel,
      required this.departmentModel,
      required this.positionModel,
      required this.roleModel,
      required this.workModel,
      required this.no,
      required this.card,
      required this.maritalStatus,
      required this.minorChild,
      required this.spouseJob,
      required this.note,
      required this.officeTel,
      required this.address});
}

class DepartmentModel {
  final String id;
  final String departmentName;
  final String loationId;
  final String workId;

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
        id: json["id"].toString(),
        departmentName: json["department_name"],
        loationId: json["location_id"].toString(),
        workId: json["working_id"].toString());
  }
  DepartmentModel(
      {required this.id,
      required this.departmentName,
      required this.loationId,
      required this.workId});
}

class PositionModel {
  final String id;
  final String positionName;
  final String type;

  factory PositionModel.fromJson(Map<String, dynamic> json) {
    return PositionModel(
        id: json["id"].toString(),
        positionName: json["position_name"],
        type: json["type"]);
  }
  PositionModel(
      {required this.id, required this.positionName, required this.type});
}

class RoleModel {
  final String id;
  final String name;
  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(id: json["id"].toString(), name: json["name"]);
  }
  RoleModel({required this.id, required this.name});
}

class WorkdayModel {
  final String id;
  final String name;
  final String typeDateTime;
  final String dateTime;
  final String workday;
  final String offday;
  final String notes;
  factory WorkdayModel.fromJson(Map<String, dynamic> json) {
    return WorkdayModel(
        name: json["name"],
        id: json["id"].toString(),
        typeDateTime: json["type_date_time"].toString(),
        dateTime: json["date_time"].toString(),
        workday: json["working_day"],
        offday: json["off_day"].toString(),
        notes: json["notes"]);
  }
  WorkdayModel(
      {required this.name,
      required this.id,
      required this.typeDateTime,
      required this.dateTime,
      required this.workday,
      required this.offday,
      required this.notes});
}

class StoreModel {
  final String id;
  final String storeName;
  final String service;
  final String locationId;
  final LocationModel locationModel;

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
        id: json["id"].toString(),
        storeName: json["store_name"],
        service: json["service"],
        locationModel: LocationModel.fromJson(json["location"]),
        locationId: json["location_id"].toString());
  }
  StoreModel(
      {required this.id,
      required this.storeName,
      required this.service,
      required this.locationModel,
      required this.locationId});
}

class LocationModel {
  final String id;
  final String locationName;
  final String lat;
  final String lon;
  final String addDetail;

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
        id: json["id"].toString(),
        locationName: json["name"],
        lat: json["lat"],
        lon: json["lon"],
        addDetail: json["address_detail"]);
  }
  LocationModel(
      {required this.id,
      required this.locationName,
      required this.lat,
      required this.lon,
      required this.addDetail});
}
