import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_face/constants.dart';
import 'package:simple_face/core/utilis/api/dio_consumer.dart';

import 'package:simple_face/features/authentication/presentation/view_model/user_sign_up/user_sign_up_cubit.dart';
import 'package:simple_face/features/authentication/presentation/widgets/sing_up_view_body.dart';

import 'package:simple_face/features/authentication/repos/auth_repo_imp_two.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserSignUpCubit(AuthRepoImpTwo(api:DioConsumer(dio:Dio()))),
      child: Scaffold(
        backgroundColor: kPrimaryColorA,
        
        body: SafeArea(child: SingUpViewBody()),
      ),
    );
  }
}
