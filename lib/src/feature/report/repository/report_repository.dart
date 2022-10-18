import 'package:dio/dio.dart';
import 'package:e_learning/src/feature/report/model/attendance_model.dart';
import 'package:e_learning/src/feature/report/model/report_model.dart';
import 'package:e_learning/src/utils/service/api_provider.dart';
import 'package:e_learning/src/utils/service/custome_exception.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ReportRepository {
  String mainUrl = "${dotenv.env['baseUrl']}";
  ApiProvider apiProvider = ApiProvider();
  Future<List<AttendanceModel>> getAttandance({
    required int page,
    required int rowperpage,
    required String startDate,
    required String endDate,
  }) async {
    try {
      print(page);
      print(rowperpage);
      String url =
          "${dotenv.env['baseUrl']}me/attendances?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      // String url = mainUrl + "me/leaves?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        print(response.data);
        List<AttendanceModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(AttendanceModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<ReportModel> getReport({
    required String startDate,
    required String endDate,
  }) async {
    try {
      String url =
          "${dotenv.env['baseUrl']}me/reports?from_date=$startDate&to_date=$endDate";
      // String url = mainUrl + "me/leaves?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        return ReportModel.fromJson(response.data);
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}
