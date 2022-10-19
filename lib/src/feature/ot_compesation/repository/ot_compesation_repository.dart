import 'package:dio/dio.dart';
import 'package:e_learning/src/feature/ot_compesation/model/ot_compesation_model.dart';
import 'package:e_learning/src/feature/overtime/model/overtime_model.dart';
import 'package:e_learning/src/utils/service/api_provider.dart';
import 'package:e_learning/src/utils/service/custome_exception.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OTCompesationRepository {
  String mainUrl = "${dotenv.env['baseUrl']}";
  ApiProvider _apiProvider = ApiProvider();
  // for specific user
  Future<List<OTCompesationModel>> getOTCompesation(
      {required int page,
      required int rowperpage,
      required String startDate,
      required String endDate}) async {
    try {
      String url =
          "${dotenv.env['baseUrl']}me/compesations?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      // String url = mainUrl + "me/leaves?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      Response response = await _apiProvider.get(url, null, null);

      if (response.statusCode == 200) {
        print(response.data);
        List<OTCompesationModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(OTCompesationModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<OvertimeModel>> getOvertime(
      {required int page,
      required int rowperpage,
      required String startDate,
      required String endDate}) async {
    try {
      String url =
          "${dotenv.env['baseUrl']}chief/overtimes/departments?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      // String url = mainUrl + "me/leaves?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      Response response = await _apiProvider.get(url, null, null);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        print(response.data);
        List<OvertimeModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(OvertimeModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addOTCompesation(
      {required String reason,
      required String duration,
      required String fromDate,
      required String type,
      required String createDate,
      required String date,
      required String toDate}) async {
    try {
      String url = mainUrl + "me/compesations/add";
      Map body = {
        "reason": reason,
        "from_date": fromDate,
        "to_date": toDate,
        "duration": duration,
        "type": type,
        "created_at": createDate,
        "date": date,
      };
      Response response = await _apiProvider.post(url, body, null);

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

  // song mong or chom nous

  Future<void> editOTCompesation(
      {required String id,
      required String reason,
      required String duration,
      required String fromDate,
      required String type,
      required String createDate,
      required String date,
      required String toDate}) async {
    try {
      String url = mainUrl + "me/compesations/edit/$id";
      Map body = {
        "reason": reason,
        "from_date": fromDate,
        "to_date": toDate,
        "duration": duration,
        "type": type,
        "created_at": createDate,
        "date": date,
      };
      print(reason);
      print(fromDate);
      print(toDate);
      print(type);
      Response response = await _apiProvider.put(url, body);

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

  Future<void> deleteOTCompesation({
    required String id,
  }) async {
    try {
      String url = mainUrl + "me/compesations/delete/$id";

      Response response = await _apiProvider.delete(url, null);

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

  Future<void> editStatusOT({
    required String id,
    required String status,
    required String paytype,
  }) async {
    try {
      String url = mainUrl + "me/compesations/edit/$id";
      Map body = {
        "status": status,
        "pay_type": paytype,
      };
      // print(userId);
      Response response = await _apiProvider.put(url, body);

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

  // user edit status accept or not , and
  // if accept , return cash or holiday instead
  // Future<void> editStatusOvertime({
  //   required String id,
  //   required String status,
  //   required String type,
  // }) async {
  //   try {
  //     String url = mainUrl + "me/overtimes/edit/$id";
  //     Map body = {};
  //     Response response = await _apiProvider.put(url, body);
  //     print(response.statusCode);
  //     if (response.statusCode == 200 && response.data["code"] == 0) {
  //       print(response.data);
  //       return;
  //     } else if (response.data["code"].toString() != "0") {
  //       throw response.data["message"];
  //     }
  //     throw CustomException.generalException();
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // Future<void> editOvertime(
  //     {required String id,
  //     required String userId,
  //     required String reason,
  //     required String duration,
  //     required String fromDate,
  //     required String notes,
  //     required String type,
  //     required String toDate}) async {
  //   try {
  //     String url = mainUrl + "chief/overtimes/edit/$id";
  //     Map body = {
  //       "reason": reason,
  //       "from_date": fromDate,
  //       "to_date": toDate,
  //       "user_id": userId,
  //       "number": duration,
  //       "note": notes,
  //       "type": type
  //     };
  //     Response response = await _apiProvider.put(url, body);
  //     print(response.statusCode);
  //     if (response.statusCode == 200 && response.data["code"] == 0) {
  //       print(response.data);
  //       return;
  //     } else if (response.data["code"].toString() != "0") {
  //       throw response.data["message"];
  //     }
  //     throw CustomException.generalException();
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // Future<void> deleteOvertime({
  //   required String id,
  // }) async {
  //   try {
  //     String url = mainUrl + "chief/overtimes/delete/$id";
  //     Response response = await _apiProvider.delete(url, null);
  //     print(response.statusCode);
  //     if (response.statusCode == 200 && response.data["code"] == 0) {
  //       print(response.data);
  //       return;
  //     } else if (response.data["code"].toString() != "0") {
  //       throw response.data["message"];
  //     }
  //     throw CustomException.generalException();
  //   } catch (e) {
  //     throw e;
  //   }
  // }
  Future<List<OTCompesationModel>> getSongMong(
      {required int page,
      required int rowperpage,
      required String startDate,
      required String endDate}) async {
    try {
      String url =
          "${dotenv.env['baseUrl']}me/songmongs?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      // String url = mainUrl + "me/leaves?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      Response response = await _apiProvider.get(url, null, null);

      if (response.statusCode == 200) {
        print(response.data);
        List<OTCompesationModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(OTCompesationModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addSonMong(
      {required String fromDate,
      required String createDate,
      required String date,
      required String toDate}) async {
    try {
      String url = mainUrl + "me/songmongs/add";
      Map body = {
        "from_date": fromDate,
        "to_date": toDate,
        "created_at": createDate,
        "date": date,
      };
      Response response = await _apiProvider.post(url, body, null);

      if (response.statusCode == 200 && response.data["code"] == 0) {
        return;
      } else if (response.data["code"].toString() != "0") {
        throw response.data["message"];
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> editSonMong(
      {required String id,
      required String fromDate,
      required String createDate,
      required String date,
      required String toDate}) async {
    try {
      String url = mainUrl + "me/songmongs/edit/$id";
      Map body = {
        "from_date": fromDate,
        "to_date": toDate,
        "created_at": createDate,
        "date": date,
      };
      Response response = await _apiProvider.put(url, body);

      print(response.statusCode);
      if (response.statusCode == 200 && response.data["code"] == 0) {
        return;
      } else if (response.data["code"].toString() != "0") {
        throw response.data["message"];
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteSongMong({
    required String id,
  }) async {
    try {
      String url = mainUrl + "me/songmongs/delete/$id";

      Response response = await _apiProvider.delete(url, null);

      if (response.statusCode == 200 && response.data["code"] == 0) {
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
