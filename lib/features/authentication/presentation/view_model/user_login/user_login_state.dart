part of 'user_login_cubit.dart';

@immutable
sealed class UserLoginState {}

final class UserLoginInitial extends UserLoginState {}
final class UserLoginLoading extends UserLoginState {}
final class UserLoginSuccess extends UserLoginState {
  final UserModel userModel;

  UserLoginSuccess({required this.userModel});
  
}
final class UserLoginFailure extends UserLoginState {
  final String errorMsg;

  UserLoginFailure({required this.errorMsg});
}