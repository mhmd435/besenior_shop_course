part of 'login_bloc.dart';

class LoginState {
  LoginDataStatus loginDataStatus;
  CodeCheckStatus codeCheckStatus;

  LoginState({
    required this.loginDataStatus,
    required this.codeCheckStatus,
  });

  LoginState copyWith({
    LoginDataStatus? newLoginDataStatus,
    CodeCheckStatus? newCodeCheckStatus,
  }){
    return LoginState(
      loginDataStatus: newLoginDataStatus ?? loginDataStatus,
      codeCheckStatus: newCodeCheckStatus ?? codeCheckStatus,
    );
  }
}

