import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_face/constants.dart';
import 'package:simple_face/core/utilis/api_service.dart';
import 'package:simple_face/features/authentication/presentation/view_model/forget_password/forget_password_cubit.dart';
import 'package:simple_face/features/authentication/presentation/view_model/verify_code/verify_code_cubit.dart';
import 'package:simple_face/features/authentication/presentation/views/codeCheck.dart';
import 'package:simple_face/features/authentication/repos/auth_repo_imp.dart';

class CodeCheckView extends StatelessWidget {
  const CodeCheckView({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
               BlocProvider(
          create: (context) => VerifyCodeCubit(AuthRepoImp(api: ApiService())),
        ),
        BlocProvider(
          create: (context) =>
              ForgetPasswordCubit(AuthRepoImp(api: ApiService())),
        ),
      ],
      child: Scaffold(
        backgroundColor: kPrimaryColorA,
        body: SafeArea(child: 
        Codecheck(email: email)
        ),
      ),
    );
  }
}