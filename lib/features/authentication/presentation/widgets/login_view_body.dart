import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_face/core/utilis/Styles.dart';
import 'package:simple_face/core/utilis/app_router.dart';
import 'package:simple_face/features/authentication/presentation/view_model/user_login/user_login_cubit.dart';
import 'package:simple_face/features/authentication/presentation/widgets/custom_button.dart';
import 'package:simple_face/features/authentication/presentation/widgets/custom_form_feild.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  GlobalKey<FormState> formKey = GlobalKey();

  late TextEditingController email, password;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text("Hello!", style: Styles.textStyle30),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text("Welcome back", style: Styles.textStyle18),
        ),
        SizedBox(height: 30),
        Expanded(
          child: Container(
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Login", style: Styles.textStyle20),
                    ),

                    SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFeild(
                        hint: "Email",
                        icon: Icons.email,
                        textController: email,
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFeild(
                        textController: password,
                        hint: "Password",
                        obscureText: true,
                        icon: Icons.lock,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GestureDetector(
                          onTap: () {
                            GoRouter.of(
                              context,
                            ).push(AppRouter.kForgetPassword);
                          },
                          child: Text(
                            "Forget Password",
                            style: Styles.textStyle12,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 30),
                    BlocConsumer<UserLoginCubit, UserLoginState>(
                      listener: (context, state) {
                        if (state is UserLoginSuccess) {
                          snackBarMethod(context, "Login Success");
                          log(state.userModel.profileImageUrl.toString());
                        } else if (state is UserLoginFailure) {
                          snackBarMethod(context, state.errorMsg);
                        }
                      },
                      builder: (context, state) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomButton(
                              child: state is UserLoginLoading
                                  ? CircularProgressIndicator(color: Colors.white,)
                                  : Text(
                                      "Login",
                                      style: TextStyle(color: Colors.white),
                                    ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<UserLoginCubit>(
                                    context,
                                  ).login(
                                    email: email.text,
                                    password: password.text,
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: Styles.textStyle12.copyWith(
                            color: const Color.fromARGB(255, 185, 183, 183),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push(AppRouter.kSignUp);
                          },
                          child: Text(
                            "Sign Up",
                            style: Styles.textStyle12.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void snackBarMethod(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
