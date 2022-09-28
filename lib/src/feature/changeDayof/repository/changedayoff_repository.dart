import 'package:dio/dio.dart';
import 'package:e_learning/src/feature/changeDayof/model/changeday_off_model.dart';

import 'package:e_learning/src/utils/service/api_provider.dart';
import 'package:e_learning/src/utils/service/custome_exception.dart';

class ChangeDayoffRepository {
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

  Future<List<ChangeDayOffModel>> getChangeOff(
      {required int page,
      required int rowperpage,
      required String startDate,
      required String endDate}) async {
    try {
      String url =
          "https://banban-hr.herokuapp.com/api/me/dayoffs?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      // String url = mainUrl + "me/leaves?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        print(response.data);
        List<ChangeDayOffModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(ChangeDayOffModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<ChangeDayOffModel>> getAllChangeDayoff(
      {required int page,
      required int rowperpage,
      required String startDate,
      required String endDate}) async {
    try {
      String url =
          "https://banban-hr.herokuapp.com/api/dayoffs/chief?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      // String url = mainUrl + "me/leaves?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        print(response.data);
        List<ChangeDayOffModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(ChangeDayOffModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  // for staff is chief department
  Future<void> editChangeDayoffStatus({
    required String id,
    required String status,
  }) async {
    try {
      String url = mainUrl + "dayoffs/chief/edit/$id";
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

  Future<void> addChangeDayOff({
    required String reason,
    required String fromDate,
    required String type,
    required String toDate,
    required String? workdayId,
    required String? holidayId,
  }) async {
    try {
      String url = mainUrl + "me/dayoffs/add";
      print(holidayId);
      Map body = {
        "type": type,
        "reason": reason,
        "workday_id": workdayId,
        "holiday_id": holidayId,
        "from_date": fromDate,
        "to_date": toDate,
      };
      // Map body = workdayId == "" ||
      //         workdayId == null && holidayId == "" ||
      //         holidayId == null
      //     ? {
      //         "type": type,
      //         "reason": reason,
      //         "from_date": fromDate,
      //         "to_date": toDate,
      //       }
      //     : workdayId != ""
      //         ? {
      //             "type": type,
      //             "reason": reason,
      //             "workday_id": workdayId,
      //             "from_date": fromDate,
      //             "to_date": toDate,
      //           }
      //         : holidayId != ""
      //             ? {
      //                 "type": type,
      //                 "reason": reason,
      //                 "holiday_id": holidayId,
      //                 "from_date": fromDate,
      //                 "to_date": toDate,
      //               }
      //             : {
      //                 "type": type,
      //                 "reason": reason,
      //                 "workday_id": workdayId,
      //                 "holiday_id": holidayId,
      //                 "from_date": fromDate,
      //                 "to_date": toDate,
      //               };
      print(holidayId);
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

  Future<void> editChangeDayoff({
    required String id,
    required String reason,
    required String fromDate,
    required String type,
    required String toDate,
    required String? workdayId,
    required String? holidayId,
  }) async {
    try {
      String url = mainUrl + "me/dayoffs/edit/$id";
      Map body = {
        "type": type,
        "reason": reason,
        "workday_id": workdayId,
        "holiday_id": holidayId,
        "from_date": fromDate,
        "to_date": toDate,
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

  Future<void> deleteChangeDayoff({
    required String id,
  }) async {
    try {
      String url = mainUrl + "me/dayoffs/delete/$id";

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

  // workday

}
