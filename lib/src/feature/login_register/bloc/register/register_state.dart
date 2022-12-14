import 'package:e_learning/src/feature/auth/model/user_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


@immutable
abstract class RegisterState extends Equatable {
  RegisterState([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class Initializing extends RegisterState {}

class Registered extends RegisterState {
  // final String token;
  final UserModel userModel;
  Registered({required this.userModel});
}

class Registering extends RegisterState {}

class ErrorRegistering extends RegisterState {
  final dynamic error;
  ErrorRegistering({required this.error});
}
