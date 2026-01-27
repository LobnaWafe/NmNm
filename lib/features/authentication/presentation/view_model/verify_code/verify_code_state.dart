part of 'verify_code_cubit.dart';

@immutable
sealed class VerifyCodeState {}

final class VerifyCodeInitial extends VerifyCodeState {}
final class VerifyCodeLoading extends VerifyCodeState {}
final class VerifyCodeSuccess extends VerifyCodeState {
  final String tempToken;

  VerifyCodeSuccess({required this.tempToken});
  
}
final class VerifyCodeFailure extends VerifyCodeState {
  final String errorMsg;

  VerifyCodeFailure({required this.errorMsg});
  
}