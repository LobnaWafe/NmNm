import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_face/features/authentication/repos/auth_repo.dart';

part 'verify_code_state.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  VerifyCodeCubit(this.authRepo) : super(VerifyCodeInitial());
  final AuthRepo authRepo;
  
  Future<void>verifyCode({required String email,required String code})async{
     emit(VerifyCodeLoading());
    var data=await authRepo.verifyCode(email: email, code: code);
    data.fold((failure){
      emit(VerifyCodeFailure(errorMsg: failure.errorMsg));
    }, (temp){
      log("tempToken:$temp");
      emit(VerifyCodeSuccess(tempToken: temp));
    });
  }
}
