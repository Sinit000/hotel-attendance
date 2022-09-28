import 'package:e_learning/src/feature/auth/model/user_model.dart';
import 'package:e_learning/src/utils/share/app_constant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthenticationState extends Equatable {
  final UserModel? user;
  final String? token;
  @override
  List<Object> get props => [];
  AuthenticationState({this.token, this.user});
}

class Initializing extends AuthenticationState {
  Initializing() : super(token: "");
}

class Authenticated extends AuthenticationState {
  final UserModel userModel;
  Authenticated({required this.userModel})
      : super(token: userModel.token, user: userModel);
}

class Authenticating extends AuthenticationState {
  Authenticating() : super(token: "");
}

class NotAuthenticated extends AuthenticationState {
  NotAuthenticated() : super(token: "");
}

class ErrorAuthentication extends AuthenticationState with ErrorState {
  ErrorAuthentication({required this.error}) : super(token: "");
  final dynamic error;
}

class LoggingOut extends AuthenticationState {
  LoggingOut() : super(token: "");
}

class Loggedout extends AuthenticationState {
  Loggedout() : super(token: "");
}
