
import 'dart:developer';

import 'package:besenior_shop_course/common/error_handling/check_exceptions.dart';
import 'package:besenior_shop_course/config/constants.dart';
import 'package:dio/dio.dart';

class HomeApiProvider {
  Dio dio;
  HomeApiProvider(this.dio);


  dynamic callHomeData(lat, lon) async {
    final response = await dio.get(
      "${Constants.baseUrl}/mainData",
      queryParameters: {
        "lat" : lat,
        "long" : lon,
      }
    ).onError((DioError error, stackTrace){
      return CheckExceptions.response(error.response!);
    });

    log(response.toString());

    return response;
  }

}