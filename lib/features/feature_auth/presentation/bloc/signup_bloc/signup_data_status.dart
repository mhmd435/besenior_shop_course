part of 'signup_bloc.dart';

@immutable
abstract class SignUpDataStatus {}

class SignUpDataInitial extends SignUpDataStatus {}

class SignUpDataLoading extends SignUpDataStatus {}

class SignUpCompleted extends SignUpDataStatus {
  final SignupModel signupModel;
  SignUpCompleted(this.signupModel);
}

class SignUpDataError extends SignUpDataStatus {
  final String errorMessage;
  SignUpDataError(this.errorMessage);
}
