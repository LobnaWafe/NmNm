import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' as intl;
import 'package:simple_face/core/utilis/app_router.dart';
import 'package:simple_face/features/home/data/models/my_chats_model.dart';
import 'package:simple_face/features/home/data/models/users_system_mode.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key, required this.chats});
  final MyChatsModel chats;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () {
          GoRouter.of(context).push(AppRouter.kRoomView,extra: UsersSystemMode(id: chats.userId,
          email: chats.email,profileImageUrl: chats.profileImage,fullName: chats.fullName
          ));
        },
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage:
              (chats.profileImage != null && chats.profileImage!.isNotEmpty)
              ? NetworkImage(chats.profileImage!)
              : AssetImage("assets/images/avatar.png"),
        ),
        title: Text(chats.fullName),
        subtitle: Text(chats.lastMessage),
        trailing: Text(formattedTime(chats.lastMessageTime)),
      ),
    );
  }

  String formattedTime(DateTime createdAt) {
    return intl.DateFormat('h:mm a').format(createdAt);
  }
}
