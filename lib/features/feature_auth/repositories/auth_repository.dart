
import 'package:dio/dio.dart';
import '../../../common/error_handling/app_exception.dart';
import '../../../common/error_handling/check_exceptions.dart';
import '../../../common/params/signup_params.dart';
import '../../../common/resources/data_state.dart';
import '../data/data_source/auth_api_provider.dart';
import '../data/models/code_model.dart';
import '../data/models/login_with_sms_model.dart';
import '../data/models/signup_model.dart';

class AuthRepository {
  AuthApiProvider apiProvider;
  AuthRepository(this.apiProvider);

  Future<DataState<SignupModel>> fetchSignUpData(SignUpParams signUpParams) async {
    try{
      Response response = await apiProvider.callSignUp(signUpParams);

      if(response.data['status'].toString() == "success"){
        // convert json to models class
        final SignupModel signupModel = SignupModel.fromJson(response.data);
        return DataSuccess(signupModel);
      }else{
        print(response.data['message']);
        return DataFailed(response.data['message']);
      }
    } on AppException catch(e){
      return await CheckExceptions.getError(e);
    }
  }


  Future<DataState<LoginWithSmsModel>> fetchLoginSms(phoneNumber) async {
    try{
      Response response = await apiProvider.callLoginWithSms(phoneNumber);

      if(response.statusCode == 200){
        print(response.data['status'] );
        if(response.data['status'].toString() != "error"){
          // convert json to models class
          final LoginWithSmsModel loginWithSmsModel = LoginWithSmsModel.fromJson(response.data);
          return DataSuccess(loginWithSmsModel);
        }else{
          print(response.data['message']);
          return DataFailed(response.data['message']);
        }
      }else{
        throw ServerException();
      }

    } on AppException catch(e){
      return DataFailed(e.getMessage());
    }
  }

  Future<DataState<CodeModel>> fetchCodeCheckData(code) async {
    try{
      Response response = await apiProvider.callCodeCheck(code);

      if(response.statusCode == 200){
        // convert json to models class
        final CodeModel codeModel = CodeModel.fromJson(response.data);
        return DataSuccess(codeModel);
      }else{
        throw ServerException();
      }

    } on AppException catch(e){
      return DataFailed(e.getMessage());
    }
  }

  Future<DataState<LoginWithSmsModel>> fetchRegisterCodeCheckData(mobile) async {
    try{
      Response response = await apiProvider.callRegisterCodeCheck(mobile);

      if(response.statusCode == 200){
        if(response.data['status'].toString() == "success"){
          // convert json to models class
          final LoginWithSmsModel loginWithSmsModel = LoginWithSmsModel.fromJson(response.data);
          return DataSuccess(loginWithSmsModel);
        }else{
          return DataFailed(response.data["message"]);
        }

      }else{
        throw ServerException();
      }

    } on AppException catch(e){
      return DataFailed(e.getMessage());
    }
  }

}