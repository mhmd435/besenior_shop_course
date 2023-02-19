part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoadLoginSms extends LoginEvent {
  final String phoneNumber;
  LoadLoginSms(this.phoneNumber);
}

class LoadCodeCheck extends LoginEvent {
  final String code;
  LoadCodeCheck(this.code);
}
