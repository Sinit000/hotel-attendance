import 'package:dio/dio.dart';
import 'package:e_learning/src/feature/timetable/model/schedule_model.dart';
import 'package:e_learning/src/feature/timetable/model/timetable_model.dart';
import 'package:e_learning/src/utils/service/api_provider.dart';
import 'package:e_learning/src/utils/service/custome_exception.dart';

class TimetableRepository{
    String mainUrl = "https://banban-hr.herokuapp.com/api/";
  ApiProvider apiProvider = ApiProvider();
  Future<List<ScheduleModel>> getTime() async {
    try {
      String url = mainUrl + "me/schedules";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
      print(response.data);
        List<ScheduleModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(ScheduleModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}