import 'package:e_learning/src/feature/auth/model/user_model.dart';
import 'package:e_learning/src/utils/service/storage.dart';

class AuthenticationRepository {
  Storage _storage = Storage();
  Future<void> saveToken({required UserModel userModel}) async {
    // await _storage.saveToken(token: token);
    await _storage.saveCurrentUser(user: userModel);
  }

  Future<UserModel?> getToken() async {
    return await _storage.getCurrentUser();
    // return await _storage.getToken();
  }

  Future<void> removeToken() async {
    return await _storage.removeToken();
  }
}
