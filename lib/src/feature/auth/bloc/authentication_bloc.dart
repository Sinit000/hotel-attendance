import 'package:e_learning/src/feature/auth/model/user_model.dart';
import 'package:e_learning/src/feature/auth/repository/auth_repository.dart';
import 'package:e_learning/src/utils/service/api_provider.dart';
import 'package:e_learning/src/utils/service/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  /// {@macro counter_bloc}
  AuthenticationBloc() : super(Authenticating());
  AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  Storage _storage = Storage();
  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is CheckingAuthenticationStarted) {
      yield Initializing();
      // String _token = await _authenticationRepository.getToken();
      UserModel? _user;
      await Future.delayed(Duration(milliseconds: 1500), () async {
        _user = await _storage.getCurrentUser();
      });
      if (_user == null) {
        yield NotAuthenticated();
      } else {
        ApiProvider.accessToken = _user!.token!;
        yield Authenticated(userModel: _user!);
      }
    }
    // if (event is CheckingAuthenticationStarted) {
    //   yield Initializing();
    //   String? _token = await _authenticationRepository.getToken();
    //   if (_token == null) {
    //     yield NotAuthenticated();
    //   } else {
    //     ApiProvider.accessToken = _token;

    //     yield Authenticated(token: _token);
    //   }
    // }
    if (event is AuthenticationStarted) {
      yield Authenticating();
      print(event.user.token!);
      await _authenticationRepository.saveToken(userModel: event.user);
      // save token as global
      ApiProvider.accessToken = event.user.token!;
      print("save token");
      print(event.user.token!);
      yield Authenticated(userModel: event.user);
    }
    if (event is LogoutPressed) {
      yield LoggingOut();
      await _authenticationRepository.removeToken();
      ApiProvider.accessToken = "";
      await Future.delayed(Duration(seconds: 1));
      yield NotAuthenticated();
    }
  }
}
