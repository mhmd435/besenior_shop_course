
import 'dart:developer';

import 'package:besenior_shop_course/config/constants.dart';
import 'package:dio/dio.dart';

class HomeApiProvider {
  Dio dio;
  HomeApiProvider(this.dio);


  dynamic callHomeData() async {
    final response = await dio.get(
      "${Constants.baseUrl}/mainData"
    );

    log(response.toString());

    return response;
  }

}