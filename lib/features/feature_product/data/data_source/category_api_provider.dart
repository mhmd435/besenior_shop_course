
import 'dart:developer';

import 'package:besenior_shop_course/common/error_handling/check_exceptions.dart';
import 'package:besenior_shop_course/config/constants.dart';
import 'package:dio/dio.dart';

class CategoryApiProvider {
  Dio dio;
  CategoryApiProvider(this.dio);

  dynamic callCategories() async{
    try{
      final response = await dio.get(
        "${Constants.baseUrl}/categories/tree"
      );
      log(response.toString());
      return response;
    }on DioError catch(e){
      return CheckExceptions.response(e.response!);
    }
  }
}