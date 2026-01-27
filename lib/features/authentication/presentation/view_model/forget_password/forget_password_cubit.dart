import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_face/features/authentication/repos/auth_repo.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.authRepo) : super(ForgetPasswordInitial());
  final AuthRepo authRepo;

  Future<void>forgetPassword({required String email})async{
    emit(ForgetPasswordLoading());
    var data = await authRepo.forgetPassword(email: email);
    data.fold((failure){
      emit(ForgetPasswordFailure(errorMsg: failure.errorMsg));
    }, (r){
       emit(ForgetPasswordSuccess());
    });
  }
}
