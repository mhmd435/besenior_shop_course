
import 'dart:developer';

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
        "lon" : lon,
      }
    );

    log(response.toString());

    return response;
  }

}