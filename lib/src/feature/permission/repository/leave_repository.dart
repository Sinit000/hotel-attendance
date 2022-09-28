import 'package:dio/dio.dart';
import 'package:e_learning/src/feature/permission/model/leave_model.dart';
import 'package:e_learning/src/feature/permission/model/leave_type_model.dart';
import 'package:e_learning/src/utils/service/api_provider.dart';
import 'package:e_learning/src/utils/service/custome_exception.dart';

class LeaveRepository {
  String mainUrl = "https://banban-hr.herokuapp.com/api/";
  ApiProvider apiProvider = ApiProvider();
  Future<List<LeaveTypeModel>> getleavetype() async {
    try {
      String url = mainUrl + "me/leavetypes";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<LeaveTypeModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(LeaveTypeModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<LeaveModel>> getleave(
      {required int page,
      required int rowperpage,
      required String startDate,
      required String endDate}) async {
    try {
      String url =
          "https://banban-hr.herokuapp.com/api/me/leaves?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      // String url = mainUrl + "me/leaves?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        print(response.data);
        List<LeaveModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(LeaveModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<LeaveModel>> getAllLeave(
      {required int page,
      required int rowperpage,
      required String startDate,
      required String endDate}) async {
    try {
      String url =
          "https://banban-hr.herokuapp.com/api/leaves/chief?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      // String url = mainUrl + "me/leaves?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        print(response.data);
        List<LeaveModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(LeaveModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  // for staff is chief department
  Future<void> editleaveStatus({
    required String id,
    required String status,
    required String leaveDeduction,
  }) async {
    try {
      String url = mainUrl + "leaves/chief/edit/$id";
      Map body = {
        "leave_deduction": leaveDeduction,
        "status": status,
      };
      Response response = await apiProvider.put(url, body);

      print(response.statusCode);
      if (response.statusCode == 200 && response.data["code"] == 0) {
        print(response.data);
        return;
      } else if (response.data["code"].toString() != "0") {
        throw response.data["message"];
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addleave(
      {
      // required String employeeId,
      required String leavetypeId,
      required String reason,
      required String number,
      required String fromDate,
      required String notes,
      required String imgUrl,
      required String type,
      required String createDate,
      required String date,
      required String toDate}) async {
    try {
      String url = mainUrl + "me/leaves/add";
      Map body = {
        "type": type,
        // "subtype": subtype,
        "note": notes,
        "reason": reason,
        "number": number,
        "from_date": fromDate,
        "image_url": imgUrl,
        "to_date": toDate,
        "leave_type_id": leavetypeId,
        "created_at": createDate,
        "date": date,
      };
      Response response = await apiProvider.post(url, body, null);

      print(response.statusCode);
      if (response.statusCode == 200 && response.data["code"] == 0) {
        print(response.data);
        return;
      } else if (response.data["code"].toString() != "0") {
        throw response.data["message"];
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> editleave(
      {required String id,
      required String leavetypeId,
      required String reason,
      required String number,
      required String fromDate,
      required String notes,
      required String imgUrl,
      required String type,
      required String createDate,
      required String date,
      required String toDate}) async {
    try {
      String url = mainUrl + "me/leaves/edit/$id";
      Map body = {
        "type": type,
        // "subtype": subtype,
        "note": notes,
        "reason": reason,
        "number": number,
        "from_date": fromDate,
        "image_url": imgUrl,
        "to_date": toDate,
        "leave_type_id": leavetypeId,
        "created_at": createDate,
        "date": date,
      };
      Response response = await apiProvider.put(url, body);

      print(response.statusCode);
      if (response.statusCode == 200 && response.data["code"] == 0) {
        print(response.data);
        return;
      } else if (response.data["code"].toString() != "0") {
        throw response.data["message"];
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteleave({
    required String id,
  }) async {
    try {
      String url = mainUrl + "leaves/delete/$id";

      Response response = await apiProvider.delete(url, null);
      print(response.statusCode);
      if (response.statusCode == 200 && response.data["code"] == 0) {
        print(response.data);
        return;
      } else if (response.data["code"].toString() != "0") {
        throw response.data["message"];
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}
