
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../common/params/signup_params.dart';
import '../../../../../common/resources/data_state.dart';
import '../../../data/models/login_with_sms_model.dart';
import '../../../data/models/signup_model.dart';
import '../../../repositories/auth_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';
part 'signup_data_status.dart';
part 'call_code_status.dart';


class SignupBloc extends Bloc<SignupEvent, SignupState> {
  AuthRepository authRepository;
  SignupBloc(this.authRepository) : super(
      SignupState(
          signUpDataStatus: SignUpDataInitial(),
          callCodeStatus: CallCodeInitial(),
      )) {

    on<LoadSignUp>((event, emit) async {
      /// emit loading
      emit(
        state.copyWith(
          newSignUpDataStatus: SignUpDataLoading(),
        ));

      DataState dataState = await authRepository.fetchSignUpData(event.signUpParams);

      if(dataState is DataSuccess){
        /// emit completed
        emit(state.copyWith(
          newSignUpDataStatus: SignUpCompleted(dataState.data),
        ));
      }

      if(dataState is DataFailed){
        /// emit error
        emit(state.copyWith(
            newSignUpDataStatus: SignUpDataError(dataState.error!),
        ));
      }

    });

    on<LoadRegisterCodeCheck>((event, emit) async {
      /// emit loading
      emit(
          state.copyWith(
            newCallCodeStatus: CallCodeLoading(),
          ));

      DataState dataState = await authRepository.fetchRegisterCodeCheckData(event.mobile);

      if(dataState is DataSuccess){
        /// emit completed
        emit(state.copyWith(
          newCallCodeStatus: CallCodeCompleted(dataState.data),
        ));
      }

      if(dataState is DataFailed){
        /// emit error
        emit(state.copyWith(
          newCallCodeStatus: CallCodeError(dataState.error!),
        ));
      }
    });

  }
}
