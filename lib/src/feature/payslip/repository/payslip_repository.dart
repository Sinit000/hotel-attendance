import 'package:dio/dio.dart';
import 'package:e_learning/src/feature/payslip/model/payslip_model.dart';
import 'package:e_learning/src/utils/service/api_provider.dart';
import 'package:e_learning/src/utils/service/custome_exception.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PayslipRepository {
  String mainUrl = "${dotenv.env['baseUrl']}";
  ApiProvider _apiProvider = ApiProvider();
  Future<List<PayslipModel>> getPayslip(
      {required int rowperpage,
      required int page,
      required String startDate,
      required String endDate}) async {
    try {
      String url =
          "${dotenv.env['baseUrl']}me/payslips?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";

      Response response = await _apiProvider.get(url, null, null);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        print(response.data);
        List<PayslipModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(PayslipModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}
