part of 'get_all_chats_cubit.dart';

@immutable
sealed class GetAllChatsState {}

final class GetAllChatsInitial extends GetAllChatsState {}
final class GetAllChatsLoading extends GetAllChatsState {}
final class GetAllChatsSuccess extends GetAllChatsState {
  final List<MyChatsModel> myChats;

  GetAllChatsSuccess({required this.myChats});

}
final class GetAllChatsFailure extends GetAllChatsState {
  final String errorMsg;

  GetAllChatsFailure({required this.errorMsg});

}