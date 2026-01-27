part of 'user_sign_up_cubit.dart';

@immutable
sealed class UserSignUpState {}

final class UserSignUpInitial extends UserSignUpState {}
final class UserSignUpLoading extends UserSignUpState {}
final class UserSignUpSuccess extends UserSignUpState {
  final UserModel userModel;

  UserSignUpSuccess({required this.userModel});
  
}
final class UserSignUpFailure extends UserSignUpState {
  final String errorMsg;

  UserSignUpFailure({required this.errorMsg});
}