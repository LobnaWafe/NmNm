import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:simple_face/core/error/failure.dart';
import 'package:simple_face/core/utilis/api/dio_consumer.dart';


import 'package:simple_face/features/authentication/data/user_model.dart';
import 'package:simple_face/features/authentication/repos/auth_repo.dart';

class AuthRepoImpTwo implements AuthRepo {
  final DioConsumer api;

  AuthRepoImpTwo({required this.api});

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await api.post(
        "api/Authentication/login",
        data: {"email": email, "password": password},
      );
      return right(UserModel.fromJson(response));
    } on Failure catch (failure) {
      return left(failure);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUp({
    required String email,
    required String password,
    required String name,
    required File? image,
  }) async {
    try {
      dynamic imageProfile;

      if (image != null) {
        imageProfile = await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        );
      }

      final formData = FormData.fromMap({
        "Email": email,
        "Password": password,
        "FullName": name,
        "ProfileImage": imageProfile,
      });
      var response = await api.post(
        "api/Authentication/register",
        data: formData,
      );

      return right(UserModel.fromJson(response));
    } on Failure catch (failure) {
      return left(failure);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> forgetPassword({required String email}) async {
    try {
      log(email);
      await api.post("api/Authentication/forgetPassword", data: "\"$email\"");
      return right(unit);
    } on Failure catch (failure) {
      return left(failure);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> verifyCode({
    required String email,
    required String code,
  }) async {
    try {
      // log(email);
      var response = await api.post(
        "api/Authentication/verifyResetCode",
        data: {"email": email, "code": code},
      );
      return right(response.toString());
    } on Failure catch (failure) {
      return left(failure);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> resetPassword({
    required String email,
    required String tempToken,
    required String password,
  }) async {
    try {
      // log(email);
      var response = await api.post(
        "api/Authentication/resetPassword",
        data: {"email": email, "tempToken": tempToken, "password": password},
      );
      return right(UserModel.fromJson(response));
    } on Failure catch (failure) {
      log("failure ${failure.errorMsg}");
      return left(failure);
    } catch (e) {
       log("catch ${e.toString()}");
      return left(ServerFailure(e.toString()));
    }
  }
}
