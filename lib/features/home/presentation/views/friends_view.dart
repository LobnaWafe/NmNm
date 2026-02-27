import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_face/constants.dart';
import 'package:simple_face/core/utilis/api/dio_consumer.dart';
import 'package:simple_face/features/home/presentation/view_models/get_all_users/get_all_users_cubit.dart';
import 'package:simple_face/features/home/presentation/widgets/friends_view_body.dart';
import 'package:simple_face/features/home/repos/home_repo_imp.dart';

class FriendsView extends StatelessWidget {
  const FriendsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetAllUsersCubit(HomeRepoImp(
        api: DioConsumer(dio: Dio())))..getAllUsersMethod(endPoint: "api/User/AllUsers"),
      child: Scaffold(backgroundColor: kPrimaryColorB, body: FriendsViewBody()),
    );
  }
}
