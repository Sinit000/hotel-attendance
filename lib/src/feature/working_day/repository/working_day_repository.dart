import 'package:dio/dio.dart';
import 'package:e_learning/src/feature/working_day/model/working_day_model.dart';
import 'package:e_learning/src/utils/service/api_provider.dart';
import 'package:e_learning/src/utils/service/custome_exception.dart';


class WorkingDayRepository {
  String mainUrl = "https://banban-hr.herokuapp.com/api/";
  ApiProvider apiProvider = ApiProvider();
  Future<List<WorkdayModel>> getWorkday() async {
    try {
      String url = "https://banban-hr.herokuapp.com/api/me/workdays";
      // String url = mainUrl + "me/leaves?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        print(response.data);
        List<WorkdayModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(WorkdayModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  
}
