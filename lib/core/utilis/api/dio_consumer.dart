import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:simple_face/core/error/failure.dart';
import 'package:simple_face/core/utilis/api/api_consumer.dart';
import 'package:simple_face/core/utilis/api/api_interceptor.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = "http://nmnm.runasp.net/";
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  @override
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.dioException(e);
    } on Exception catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      return response.data;
    } on DioException catch (e) {
      log("dio exception ${e.toString()}");
      throw ServerFailure.dioException(e);
    } on Exception catch (e) {
       log("server ${e.toString()}");
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.dioException(e);
    } on Exception catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.dioException(e);
    } on Exception catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
