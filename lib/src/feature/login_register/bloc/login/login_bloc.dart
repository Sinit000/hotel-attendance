import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:e_learning/src/feature/auth/model/user_model.dart';
import 'package:e_learning/src/feature/login_register/repository/login_register_repositories.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRegisterRepository _loginRegisterRepository = LoginRegisterRepository();
  @override
  LoginBloc() : super(Initializing());
  // UserModel? userModel;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginPressed) {
      yield Logging();
      try {
        Future.delayed(Duration(milliseconds: 200));
        final UserModel _user = await _loginRegisterRepository.login(
            phone: event.phoneNumber, password: event.password);
        // final String _token = await _loginRegisterRepository.login(
        //     phone: event.phoneNumber, password: event.password);
        yield Logged(userModel: _user);
      } catch (e) {
        print(e.toString());
        yield ErrorLogin(error: e.toString());
      }
    }
  }
}
