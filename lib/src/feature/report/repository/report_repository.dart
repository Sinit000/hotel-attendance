import 'package:dio/dio.dart';
import 'package:e_learning/src/feature/report/model/report_model.dart';
import 'package:e_learning/src/utils/service/api_provider.dart';
import 'package:e_learning/src/utils/service/custome_exception.dart';

class ReportRepository {
  String mainUrl = "https://banban-hr.herokuapp.com/api/";
  ApiProvider apiProvider = ApiProvider();
  Future<List<ReportModel>> getReport({
    required int page,
    required int rowperpage,
    required String startDate,
    required String endDate,
  }) async {
    try {
      print(page);
      print(rowperpage);
      String url =
          "https://banban-hr.herokuapp.com/api/me/attendances?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      // String url = mainUrl + "me/leaves?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        print(response.data);
        List<ReportModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(ReportModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
  // Future<List<ReportModel>> getReport({
  //   required int page,
  //   required int rowperpage,
  // }) async {
  //   try {
  //     String url =
  //         "https://banban-hr.herokuapp.com/api/me/attendances?page_size=$rowperpage&page=$page";
  //     // String url = mainUrl + "me/leaves?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
  //     Response response = await apiProvider.get(url, null, null);
  //     print(response.statusCode);
  //     print(url);
  //     if (response.statusCode == 200) {
  //       print(response.data);
  //       List<ReportModel> leave = [];
  //       response.data["data"].forEach((data) {
  //         leave.add(ReportModel.fromJson(data));
  //       });
  //       return leave;
  //     }
  //     throw CustomException.generalException();
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}
