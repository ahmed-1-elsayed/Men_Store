part of 'login_dart_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserModel user;

  LoginSuccess(this.user);
}

class LoginFailure extends LoginState {
  final String msg;

  LoginFailure(this.msg);
}
