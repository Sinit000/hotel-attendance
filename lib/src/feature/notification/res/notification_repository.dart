import 'package:dio/dio.dart';

import 'package:e_learning/src/feature/notification/model/notification_model.dart';
import 'package:e_learning/src/utils/service/api_provider.dart';
import 'package:e_learning/src/utils/service/custome_exception.dart';

class NotificationRepository {
  String mainUrl = "https://banban-hr.herokuapp.com/api/";
  ApiProvider apiProvider = ApiProvider();
  Future<List<NotificationModel>> getNotification(
      {required int rowperpage, required int page}) async {
    try {
      String url = mainUrl + "notifications?page_size=$rowperpage&page=$page";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<NotificationModel> anounce = [];
        response.data["data"].forEach((data) {
          anounce.add(NotificationModel.fromJson(data));
        });
        return anounce;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}
