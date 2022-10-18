import 'package:dio/dio.dart';
import 'package:e_learning/src/feature/account/model/account_model.dart';
import 'package:e_learning/src/feature/account/model/counter_model.dart';
import 'package:e_learning/src/utils/service/api_provider.dart';
import 'package:e_learning/src/utils/service/custome_exception.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AccountRepository {
  int rowPerPage = 10;
  String mainUrl = "${dotenv.env['baseUrl']}";
  ApiProvider apiProvider = ApiProvider();
  Future<AccountModel> getAccount() async {
    try {
      String url = mainUrl + "me/profile";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);

        return AccountModel.fromJson(response.data["user"]);
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<CounterModel> getCounter() async {
    try {
      String url = mainUrl + "me/counters";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);

        return CounterModel.fromJson(response.data["data"]);
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<AccountModel> check({required String todayDate}) async {
    try {
      String url = mainUrl + "me/profile/check/$todayDate";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        //  print(json.decode(response.body));
        return AccountModel.fromJson(response.data["user"]);
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateAccount(
      {
      // required String img,
      //   required String name,
      // required String phone,
      // required String email,
      // required String city,
      // required String company,
      // required String address,
      // required String skills,
      // required String educations,
      // required String experiences,
      // required String subscriptionId,
      // required String paymentMethod,
      required String imageUrl}) async {
    try {
      String url = mainUrl + "me/profile/update";
      Map body = {
        // // "type": "company",
        "profile_url": imageUrl,
        // "phone": phone,
        // "email": email,
        // "city": city,
        // "company": company,
        // "address": address,
        // "skills": skills,
        // "educations": educations,
        // "experiences": experiences,
        // "image_url": imageUrl,
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

  Future<void> upgradeAccount(
      {required String subscriptionId,
      required String paymentMethod,
      required String imageUrl}) async {
    try {
      String url = mainUrl + "upgrade";
      Map body = {
        "type": "company",
        "subscription_plan_id": subscriptionId,
        "payment_type": "transfer",
        "payment_method": paymentMethod,
        "image_url": imageUrl,
      };
      print(imageUrl);
      print(url);
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

  Future<void> checkin(
      {required String checkinTime,
      required String lat,
      required String lon,
      required String date,
      required String createDate,
      required String qrId}) async {
    try {
      String url = mainUrl + "me/checkins/add";
      print(checkinTime);
      print(createDate);
      print(date);
      Map body = {
        "checkin_time": checkinTime,
        "lat": lat,
        "lon": lon,
        "created_at": createDate,
        "date": date,
        "qr_id": qrId
      };
      // print('lat $lat and long $lon');
      Response response = await apiProvider.post(url, body, null);

      print(response.statusCode);
      if (response.statusCode == 200 && response.data["code"] == 0) {
        print(response.data);
        return;
      } else if (response.data["code"].toString() != "0") {
        // throw response.data["distance"];
        throw response.data["message"];
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> checkout({
    required String id,
    required String checkoutTime,
    required String lat,
    required String lon,
    required String date,
    // required String locationId,
    required String qrId,
    // required String timetableId
  }) async {
    try {
      print(id);
      String url = mainUrl + "me/checkouts/edit/$id";
      Map body = {
        // "type": "company",
        "checkout_time": checkoutTime,
        "lat": lat,
        "lon": lon,
        // "location_id": locationId,
        "date": date,
        "qr_id": qrId
        // "timetable_id": timetableId
      };
      print(checkoutTime);
      print(date);

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
}
