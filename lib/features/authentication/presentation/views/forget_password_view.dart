import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_face/constants.dart';
import 'package:simple_face/core/utilis/Styles.dart';
import 'package:simple_face/core/utilis/api_service.dart';
import 'package:simple_face/core/utilis/app_router.dart';
import 'package:simple_face/features/authentication/presentation/view_model/forget_password/forget_password_cubit.dart';
import 'package:simple_face/features/authentication/presentation/widgets/custom_button.dart';
import 'package:simple_face/features/authentication/presentation/widgets/custom_form_feild.dart';
import 'package:simple_face/features/authentication/repos/auth_repo_imp.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  GlobalKey<FormState> formKey = GlobalKey();

  late TextEditingController email;

  @override
  void initState() {
    email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(AuthRepoImp(api: ApiService())),
      child: Scaffold(
        backgroundColor: kPrimaryColorA,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Forget Password", style: Styles.textStyle30),
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
                          Text("Enter Your Email", style: Styles.textStyle20),

                          SizedBox(height: 20),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextFeild(
                              hint: "Email",
                              icon: Icons.email,
                              textController: email,
                            ),
                          ),

                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: GestureDetector(
                                onTap: () {
                                  // GoRouter.of(context).push(AppRouter.kLogin);
                                  context.go(AppRouter.kLogin);
                                },
                                child: Text(
                                  "Back to Sign in",
                                  style: Styles.textStyle12,
                                ),
                              ),
                            ),
                          ),

                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  BlocConsumer<
                                    ForgetPasswordCubit,
                                    ForgetPasswordState
                                  >(
                                    listener: (context, state) {
                                      if (state is ForgetPasswordFailure) {
                                        snackBarMethod(context, state.errorMsg);
                                      }
                                      else if (state
                                                is ForgetPasswordSuccess) {
                                              GoRouter.of(
                                                context,
                                              ).push(AppRouter.kCodeCheck,
                                              extra: email.text
                                              );
                                            }
                                    },
                                    builder: (context, state) {
                                      return CustomButton(
                                        child: state is ForgetPasswordLoading
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
                                            //
                                            BlocProvider.of<
                                                  ForgetPasswordCubit
                                                >(context)
                                                .forgetPassword(
                                                  email: email.text,
                                                );
                                           
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
}
