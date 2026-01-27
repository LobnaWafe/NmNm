import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_face/features/authentication/data/user_model.dart';
import 'package:simple_face/features/authentication/repos/auth_repo.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this.authRepo) : super(ResetPasswordInitial());
  final AuthRepo authRepo;
  Future<void>resetPassword({required String email, required String password,required String tempToken})
  async{
    emit(ResetPasswordLoading());
    var data=await authRepo.resetPassword(email: email, password: password,tempToken: tempToken);
    data.fold((failure){
      emit(ResetPasswordFailure(errorMsg: failure.errorMsg));
    }, (user){
      emit(ResetPasswordSuccess(userModel: user));
    });
  }
}
