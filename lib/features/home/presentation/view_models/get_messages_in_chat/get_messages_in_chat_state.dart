part of 'get_messages_in_chat_cubit.dart';

@immutable
sealed class GetMessagesInChatState {}

final class GetMessagesInChatInitial extends GetMessagesInChatState {}
final class GetMessagesInChatLoading extends GetMessagesInChatState {}
final class GetMessagesInChatSuccess extends GetMessagesInChatState {
  final List<MessageModel>messages;

  GetMessagesInChatSuccess({required this.messages});

}
final class GetMessagesInChatFailure extends GetMessagesInChatState {
  final String errorMsg;

  GetMessagesInChatFailure({required this.errorMsg});

}