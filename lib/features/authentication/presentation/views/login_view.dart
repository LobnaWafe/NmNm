import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_face/constants.dart';
import 'package:simple_face/core/utilis/api_service.dart';
import 'package:simple_face/features/authentication/presentation/view_model/user_login/user_login_cubit.dart';
import 'package:simple_face/features/authentication/presentation/widgets/login_view_body.dart';
import 'package:simple_face/features/authentication/repos/auth_repo_imp.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserLoginCubit(AuthRepoImp(api: ApiService())),
      child: Scaffold(
        backgroundColor: kPrimaryColorA,
        body: SafeArea(child: LoginViewBody()),
      ),
    );
  }
}
