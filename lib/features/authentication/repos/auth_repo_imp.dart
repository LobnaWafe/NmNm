import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:simple_face/core/error/failure.dart';
import 'package:simple_face/core/utilis/api_service.dart';
import 'package:simple_face/features/authentication/data/user_model.dart';
import 'package:simple_face/features/authentication/repos/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  final ApiService api;

  AuthRepoImp({required this.api});

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await api.post(
        endPoint: "api/Authentication/login",
        data: {"email": email, "password": password},
      );
      return right(UserModel.fromJson(response));
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.dioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
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
        endPoint: "api/Authentication/register",
        data: formData,
      );

      return right(UserModel.fromJson(response));
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.dioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> forgetPassword({required String email}) async {
    try {
      log(email);
      await api.post(
        endPoint: "api/Authentication/forgetPassword",
        data: "\"$email\"",
      );
      return right(unit);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.dioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
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
        endPoint: "api/Authentication/verifyResetCode",
        data: {"email": email, "code": code},
      );
      return right(response.toString());
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.dioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
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
        endPoint: "api/Authentication/resetPassword",
        data: {"email": email, "tempToken": tempToken, "password": password},
      );
      return right(UserModel.fromJson(response));
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.dioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
