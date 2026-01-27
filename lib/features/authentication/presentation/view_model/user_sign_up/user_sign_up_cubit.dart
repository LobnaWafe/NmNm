import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_face/features/authentication/data/user_model.dart';
import 'package:simple_face/features/authentication/repos/auth_repo.dart';

part 'user_sign_up_state.dart';

class UserSignUpCubit extends Cubit<UserSignUpState> {
  UserSignUpCubit(this.authRepo) : super(UserSignUpInitial());
  
   final AuthRepo authRepo;
  Future<void>signUp({required String email, required String password,required String name , required File? image})async{
    emit(UserSignUpLoading());
    var data=await authRepo.signUp(email: email, password: password,name: name,image: image);
    data.fold((failure){
      emit(UserSignUpFailure(errorMsg: failure.errorMsg));
    }, (user){
      emit(UserSignUpSuccess(userModel: user));
    });
  }
}
