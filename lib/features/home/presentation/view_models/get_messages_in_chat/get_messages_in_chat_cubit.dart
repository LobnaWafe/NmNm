import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_face/features/home/data/models/message_model.dart';
import 'package:simple_face/features/home/repos/home_repo.dart';

part 'get_messages_in_chat_state.dart';

class GetMessagesInChatCubit extends Cubit<GetMessagesInChatState> {
  final HomeRepo homeRepo;
  List<MessageModel> allMessages = []; // نخزن الرسايل هنا

  GetMessagesInChatCubit(this.homeRepo) : super(GetMessagesInChatInitial());

  Future<void> getMessagesMethod({required String endPoint}) async {
    emit(GetMessagesInChatLoading());
    var data = await homeRepo.getMessagesInChat(endPoint: endPoint);
    data.fold(
      (failure) => emit(GetMessagesInChatFailure(errorMsg: failure.errorMsg)),
      (messages) {
        allMessages = messages;
       
      //  log("chat messages :");
      //   for (var message in allMessages) {
      //     log(message.toString());
      //   }

        emit(GetMessagesInChatSuccess(messages: List.from(allMessages)));
      },
    );
  }

  // فنكشن تناديها لما SignalR يستقبل رسالة جديدة
  void addNewMessage(MessageModel message) {
    allMessages.add(message);
    emit(GetMessagesInChatSuccess(messages: List.from(allMessages)));
  }

  void updateMessagesStatusToRead(String readerId) {
    // readerId هنا هو الشخص اللي كان مستلم رسايلي وقرأها حالاً
    allMessages = allMessages.map((msg) {
      if (msg.receiverId == readerId) {
        //  print("sernderId:${msg.senderId}");
        // print("receivedId:${msg.receiverId}");
        return msg.copyWith(readAt: DateTime.now());
      }
      return msg;
    }).toList();

    emit(GetMessagesInChatSuccess(messages: List.from(allMessages)));
  }
}
