part of 'reset_password_cubit.dart';

@immutable
sealed class ResetPasswordState {}

final class ResetPasswordInitial extends ResetPasswordState {}
final class ResetPasswordLoading extends ResetPasswordState {}
final class ResetPasswordSuccess extends ResetPasswordState {
  final UserModel userModel;

  ResetPasswordSuccess({required this.userModel});
  
}
final class ResetPasswordFailure extends ResetPasswordState {
  final String errorMsg;

  ResetPasswordFailure({required this.errorMsg});
  
}