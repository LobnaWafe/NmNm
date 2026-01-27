import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:simple_face/core/error/failure.dart';
import 'package:simple_face/features/authentication/data/user_model.dart';

abstract class AuthRepo {

  Future<Either<Failure,UserModel>>login
  ({required String email,required String password});

  Future<Either<Failure,UserModel>>signUp
  ({required String email,required String password,required String name,
  required File? image});

  Future<Either<Failure,Unit>>forgetPassword
  ({required String email});
  
  Future<Either<Failure,String>>verifyCode
  ({required String email,required String code});

   Future<Either<Failure,UserModel>>resetPassword
  ({required String email,required String tempToken,required String password});
}