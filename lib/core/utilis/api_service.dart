import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:simple_face/core/utilis/dio_client.dart';

class ApiService {
  final DioClient dio = DioClient();

  //  Future<Map<String,dynamic>>get({required String endPoint})async{
  //   var response =await dio.get("$baseUrl$endPoint");
  //   return response.data;
  //  }

  Future<T?> post<T>({
    required String endPoint,
    dynamic data,
    ResponseTypeEnum responseType = ResponseTypeEnum.json,
  }) async {
    // log(data);
   var response = await dio.dio.post(
  endPoint,
  data: data,
  options: Options(
    extra: {
      "requiresToken": false,
    },
  ),

);


    
    switch (responseType) {
      case ResponseTypeEnum.json:
        return response.data as T;

      case ResponseTypeEnum.string:
        return response.data.toString() as T;

      case ResponseTypeEnum.none:
        return null;
    }
  }
}

enum ResponseTypeEnum { json, string, none }
