import 'package:dio/dio.dart';
import 'package:e_learning/src/feature/leaveout/model/leaveout_model.dart';
import 'package:e_learning/src/feature/permission/model/leave_model.dart';
import 'package:e_learning/src/feature/permission/model/leave_type_model.dart';
import 'package:e_learning/src/utils/service/api_provider.dart';
import 'package:e_learning/src/utils/service/custome_exception.dart';

class LeaveOutRepository {
  String mainUrl = "https://banban-hr.herokuapp.com/api/";
  ApiProvider apiProvider = ApiProvider();
  // Future<List<LeaveOutModel>> getleaveout() async {
  //   try {
  //     String url = mainUrl + "me/leaveouts";

  //     Response response = await apiProvider.get(url, null, null);
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       print(response.data);
  //       List<LeaveOutModel> leave = [];
  //       response.data["data"].forEach((data) {
  //         leave.add(LeaveOutModel.fromJson(data));
  //       });
  //       return leave;
  //     }
  //     throw CustomException.generalException();
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  Future<List<LeaveOutModel>> getleaveout(
      {required int page,
      required int rowperpage,
      required String startDate,
      required String endDate}) async {
    try {
      String url =
          "https://banban-hr.herokuapp.com/api/me/leaveouts?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      // String url = mainUrl + "me/leaves?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        print(response.data);
        List<LeaveOutModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(LeaveOutModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<LeaveOutModel>> getAllLeaveoutC(
      {required int page,
      required int rowperpage,
      required String startDate,
      required String endDate}) async {
    try {
      String url =
          "https://banban-hr.herokuapp.com/api/leaveouts/chief?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      // String url = mainUrl + "me/leaves?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        print(response.data);
        List<LeaveOutModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(LeaveOutModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<LeaveOutModel>> getAllLeaveoutS(
      {required int page,
      required int rowperpage,
      required String startDate,
      required String endDate}) async {
    try {
      String url =
          "https://banban-hr.herokuapp.com/api/leaveouts/security?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      // String url = mainUrl + "me/leaves?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        print(response.data);
        List<LeaveOutModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(LeaveOutModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  // for staff is chief department
  Future<void> editleaveOutStatusC({
    required String id,
    required String status,
  }) async {
    try {
      String url = mainUrl + "leaveouts/chief/edit/$id";
      Map body = {
        // "type": "company",
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

  Future<void> editleaveOutStatusS({
    required String id,
    required String status,
  }) async {
    try {
      String url = mainUrl + "leaveouts/security/edit/$id";
      Map body = {
        // "type": "company",
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

  Future<void> addleaveOut(
      {required String reason,
      required String timein,
      required String createDate,
      required String date,
      required String timeout}) async {
    try {
      String url = mainUrl + "me/leaveouts/add";
      Map body = {
        "reason": reason,
        "time_in": timein,
        "time_out": timeout,
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

  Future<void> editleaveOut(
      {required String id,
      required String reason,
      required String timein,
      required String createDate,
      required String date,
      required String timeout}) async {
    try {
      String url = mainUrl + "me/leaveouts/edit/$id";
      Map body = {
        "reason": reason,
        "created_at": createDate,
        "date": date,
        "time_in": timein,
        "time_out": timeout,
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

  Future<void> deleteleaveOut({
    required String id,
  }) async {
    try {
      String url = mainUrl + "me/leaveouts/delete/$id";

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
