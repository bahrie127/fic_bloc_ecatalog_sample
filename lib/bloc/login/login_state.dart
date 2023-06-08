part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final LoginResponseModel model;
  LoginLoaded({
    required this.model,
  });
}

class LoginError extends LoginState {
  final String message;
  LoginError({
    required this.message,
  });
}
