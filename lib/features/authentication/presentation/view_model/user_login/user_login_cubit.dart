import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_face/core/utilis/cach_helper.dart';
import 'package:simple_face/features/authentication/data/user_model.dart';
import 'package:simple_face/features/authentication/repos/auth_repo.dart';

part 'user_login_state.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  UserLoginCubit(this.authRepo) : super(UserLoginInitial());
  final AuthRepo authRepo;
  Future<void>login({required String email, required String password})async{
    emit(UserLoginLoading());
    var data=await authRepo.login(email: email, password: password);
    
    data.fold((failure){
      emit(UserLoginFailure(errorMsg: failure.errorMsg));
    }, (user)async{
        var toekn =await CacheHelper.put(key: "token",value: user.token);
      await CacheHelper.saveUser(user);

      emit(UserLoginSuccess(userModel: user));
   
     log("cached token after login: ${user.token}");
    });
  }
  
}
