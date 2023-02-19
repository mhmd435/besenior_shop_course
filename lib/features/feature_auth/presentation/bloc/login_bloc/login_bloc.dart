
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../common/resources/data_state.dart';
import '../../../data/models/code_model.dart';
import '../../../data/models/login_with_sms_model.dart';
import '../../../repositories/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_data_status.dart';
part 'code_check_status.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepository authRepository;
  LoginBloc(this.authRepository) : super(
      LoginState(
          loginDataStatus: LoginDataInitial(),
          codeCheckStatus: CodeCheckInitial(),
      )) {


    on<LoadLoginSms>((event, emit) async {
      /// emit loading
      emit(
          state.copyWith(
            newLoginDataStatus: LoginDataLoading(),
          ));

      DataState dataState = await authRepository.fetchLoginSms(event.phoneNumber);

      if(dataState is DataSuccess){
        /// emit completed
        emit(state.copyWith(
          newLoginDataStatus: LoginDataCompleted(dataState.data),
        ));
      }

      if(dataState is DataFailed){
        /// emit error
        emit(state.copyWith(
          newLoginDataStatus: LoginDataError(dataState.error!),
        ));
      }
    });

    on<LoadCodeCheck>((event, emit) async {
      /// emit loading
      emit(
          state.copyWith(
            newCodeCheckStatus: CodeCheckLoading(),
          ));

      DataState dataState = await authRepository.fetchCodeCheckData(event.code);

      if(dataState is DataSuccess){
        /// emit completed
        emit(state.copyWith(
          newCodeCheckStatus: CodeCheckCompleted(dataState.data),
        ));
      }

      if(dataState is DataFailed){
        /// emit error
        emit(state.copyWith(
          newCodeCheckStatus: CodeCheckError(dataState.error!),
        ));
      }
    });

  }
}
