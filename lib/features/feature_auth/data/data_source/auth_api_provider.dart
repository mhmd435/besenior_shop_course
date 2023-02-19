
import 'dart:io';

import 'package:android_sms_retriever/android_sms_retriever.dart';
import 'package:dio/dio.dart';
import '../../../../common/error_handling/check_exceptions.dart';
import '../../../../common/params/signup_params.dart';
import '../../../../config/constants.dart';

class AuthApiProvider {
  Dio dio;
  AuthApiProvider(this.dio);

  dynamic callSignUp(SignUpParams signUpParams) async {
    try{
      final response = await dio.post(
        "${Constants.baseUrl}/register",
        queryParameters: {
          "name" : signUpParams.username,
          "mobile" : signUpParams.phoneNumber
        }
      );
      print(response.toString());

      return response;

    }on DioError catch(e){
      return CheckExceptions.response(e.response!);
    }
  }

  dynamic callLoginWithSms(phoneNumber) async {
    if(Platform.isAndroid){
      String? sign = await AndroidSmsRetriever.getAppSignature();
      print("app sign : " + sign!);
    }


    try{
      final response = await dio.post(
          "${Constants.baseUrl}/auth/loginWithSms",
          queryParameters: {
            "mobile" : phoneNumber,
            if(Platform.isAndroid)
              'hash': (await AndroidSmsRetriever.getAppSignature())
          }
      );
      print(response.toString());

      return response;

    }on DioError catch(e){
      return CheckExceptions.response(e.response!);
    }
  }

  dynamic callCodeCheck(code) async {
    try{
      final response = await dio.post(
          "${Constants.baseUrl}/auth/loginWithSms/check",
          queryParameters: {
            "code" : code,
          }
      );
      print(response.toString());

      return response;

    } on DioError catch(e){
      return CheckExceptions.response(e.response!);
    }
  }

  dynamic callRegisterCodeCheck(mobile) async {
    try{
      final response = await dio.post(
          "${Constants.baseUrl}/auth/sendcode",
          queryParameters: {
            "mobile" : mobile,
            if(Platform.isAndroid)
              'hash': (await AndroidSmsRetriever.getAppSignature())
          }
      );
      print(response.toString());

      return response;

    }on DioError catch(e){
      return CheckExceptions.response(e.response!);
    }
  }

}