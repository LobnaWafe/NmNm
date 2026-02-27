import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_face/constants.dart';
import 'package:simple_face/core/utilis/api/dio_consumer.dart';
import 'package:simple_face/features/home/data/models/users_system_mode.dart';
import 'package:simple_face/features/home/presentation/view_models/get_messages_in_chat/get_messages_in_chat_cubit.dart';
import 'package:simple_face/features/home/presentation/widgets/room_view_body.dart';
import 'package:simple_face/features/home/repos/home_repo_imp.dart';

class RoomView extends StatelessWidget {
  const RoomView({super.key, required this.user});
  final UsersSystemMode user;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetMessagesInChatCubit(HomeRepoImp(api: DioConsumer(dio: Dio()))),
      child: Scaffold(
        backgroundColor: kPrimaryColorB,
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage:
                    (user.profileImageUrl != null &&
                        user.profileImageUrl!.isNotEmpty)
                    ? NetworkImage(user.profileImageUrl!)
                    : AssetImage("assets/images/avatar.png"),
              ),

              const SizedBox(width: 10),
              Text(user.fullName, style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
        body: SafeArea(child: RoomViewBody(user: user)),
      ),
    );
  }
}
