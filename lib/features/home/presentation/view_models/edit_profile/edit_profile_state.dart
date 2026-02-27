part of 'edit_profile_cubit.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}
final class EditProfileLoading extends EditProfileState {}
final class EditProfileSuccess extends EditProfileState {
  final UserModel userModel;

  EditProfileSuccess({required this.userModel});
}
final class EditProfileFailure extends EditProfileState {
  final String errorMsg;

  EditProfileFailure({required this.errorMsg});
}