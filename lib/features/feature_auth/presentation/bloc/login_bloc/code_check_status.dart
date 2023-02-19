part of 'login_bloc.dart';

@immutable
abstract class CodeCheckStatus {}

class CodeCheckInitial extends CodeCheckStatus {}

class CodeCheckLoading extends CodeCheckStatus {}

class CodeCheckCompleted extends CodeCheckStatus {
  final CodeModel codeModel;
  CodeCheckCompleted(this.codeModel);
}

class CodeCheckError extends CodeCheckStatus {
  final String errorMessage;
  CodeCheckError(this.errorMessage);
}
