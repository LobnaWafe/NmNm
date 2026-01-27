import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_face/constants.dart';
import 'package:simple_face/core/utilis/Styles.dart';
import 'package:simple_face/core/utilis/api_service.dart';
import 'package:simple_face/core/utilis/app_router.dart';
import 'package:simple_face/core/utilis/cach_helper.dart';
import 'package:simple_face/features/authentication/presentation/view_model/reset_pawword/reset_password_cubit.dart';
import 'package:simple_face/features/authentication/presentation/widgets/custom_button.dart';
import 'package:simple_face/features/authentication/presentation/widgets/custom_form_feild.dart';
import 'package:simple_face/features/authentication/repos/auth_repo_imp.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({
    super.key,
    required this.email,
    required this.tempToken,
  });
  final String email, tempToken;

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  GlobalKey<FormState> formKey = GlobalKey();

  late TextEditingController newPassword;

  @override
  void initState() {
    newPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    newPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(AuthRepoImp(api: ApiService())),
      child: Scaffold(
         backgroundColor: kPrimaryColorA,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Reset Password", style: Styles.textStyle30),
              ),
              SizedBox(height: 30),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 233, 231, 231),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),

                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enter a new password",
                            style: Styles.textStyle20,
                          ),

                          SizedBox(height: 20),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextFeild(
                              hint: "New Password",
                              icon: Icons.lock,
                              textController: newPassword,
                              obscureText: true,
                            ),
                          ),

                          // Center(
                          //   child: Padding(
                          //     padding: const EdgeInsets.symmetric(vertical: 8),
                          //     child: GestureDetector(
                          //       onTap: () {

                          //       },
                          //       child: Text(
                          //         "Back to Sign in",
                          //         style: Styles.textStyle12,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  BlocConsumer<
                                    ResetPasswordCubit,
                                    ResetPasswordState
                                  >(
                                    listener: (context, state) {
                                      if (state is ResetPasswordFailure) {
                                        snackBarMethod(context, state.errorMsg);
                                      } else if (state
                                          is ResetPasswordSuccess) {
                                       snackBarMethod(context, "your password is changed");
                                       GoRouter.of(context).go(AppRouter.kLogin);
                                       CacheHelper.saveUser(state.userModel);
                                      }
                                    },
                                    builder: (context, state) {
                                      return CustomButton(
                                        child: state is ResetPasswordLoading
                                            ? CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : Text(
                                                "Continue",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {

                                                BlocProvider.of<ResetPasswordCubit>(context).resetPassword(
                                                  email:widget.email,
                                                   password: newPassword.text,
                                                   tempToken:widget.tempToken);
                                            //
                                          }
                                        },
                                      );
                                    },
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void snackBarMethod(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  tempMetho() {
    log("email:${widget.email} , tempToken:${widget.tempToken}");
  }
}
