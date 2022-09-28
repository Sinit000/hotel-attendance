import 'package:e_learning/src/feature/auth/model/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckingAuthenticationStarted extends AuthenticationEvent {}

class AuthenticationStarted extends AuthenticationEvent {
  final UserModel user;
  AuthenticationStarted({required this.user});
}

class LogoutPressed extends AuthenticationEvent {}
