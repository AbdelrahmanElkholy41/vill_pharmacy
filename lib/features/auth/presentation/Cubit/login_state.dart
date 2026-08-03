part of 'login_cubit.dart';


abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final AuthResponseEntity response;

  LoginSuccess(this.response);
}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}