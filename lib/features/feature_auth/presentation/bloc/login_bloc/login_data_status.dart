part of 'login_bloc.dart';


@immutable
abstract class LoginDataStatus {}

class LoginDataInitial extends LoginDataStatus {}

class LoginDataLoading extends LoginDataStatus {}

class LoginDataCompleted extends LoginDataStatus {
  final LoginWithSmsModel loginWithSmsModel;
  LoginDataCompleted(this.loginWithSmsModel);
}

class LoginDataError extends LoginDataStatus {
  final String errorMessage;
  LoginDataError(this.errorMessage);
}
