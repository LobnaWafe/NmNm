import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_face/constants.dart';
import 'package:simple_face/core/utilis/api/dio_consumer.dart';
import 'package:simple_face/features/home/presentation/view_models/get_all_chats/get_all_chats_cubit.dart';
import 'package:simple_face/features/home/presentation/widgets/chats_view_body.dart';
import 'package:simple_face/features/home/repos/home_repo_imp.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetAllChatsCubit(HomeRepoImp(api: DioConsumer(dio: Dio())))..getAllChatsMethod(endPoint: "api/Chat/channels")
      ,
      child: Scaffold(
        backgroundColor: kPrimaryColorB,
        body: SafeArea(child: ChatsViewBody()),
      ),
    );
  }
}
