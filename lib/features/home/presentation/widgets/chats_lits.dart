import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_face/constants.dart';
import 'package:simple_face/features/home/presentation/view_models/get_all_chats/get_all_chats_cubit.dart';
import 'package:simple_face/features/home/presentation/widgets/chat_item.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAllChatsCubit, GetAllChatsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return state is GetAllChatsSuccess? ListView.builder(
          itemCount:state.myChats.length ,
          itemBuilder: (context, index) {
            return ChatItem(
             chats : state.myChats[index]
            );
          },
        ): state is GetAllChatsLoading?Center(child: CircularProgressIndicator(color: kPrimaryColorA,),): Center(
          child: Text("Oops! it's error , please try again"),
        );
      },
    );
  }
}
