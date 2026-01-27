import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_face/core/utilis/Styles.dart';
import 'package:simple_face/features/authentication/presentation/view_model/user_sign_up/user_sign_up_cubit.dart';
import 'package:simple_face/features/authentication/presentation/widgets/custom_button.dart';
import 'package:simple_face/features/authentication/presentation/widgets/custom_form_feild.dart';
import 'package:simple_face/features/authentication/presentation/widgets/pick_image.dart';

class SingUpViewBody extends StatefulWidget {
  SingUpViewBody({super.key});

  @override
  State<SingUpViewBody> createState() => _SingUpViewBodyState();
}

class _SingUpViewBodyState extends State<SingUpViewBody> {
  GlobalKey<FormState> formKey = GlobalKey();

  late TextEditingController email, password, name;
  File? selectedImage;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    name = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text("Let's Start 🤝", style: Styles.textStyle30),
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
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Sign Up", style: Styles.textStyle20),
                      ),

                      SizedBox(height: 10),
                      //image
                      Center(
                        child: PickImage(
                          onImagePicked: (profileImage) {
                            selectedImage = profileImage;
                          },
                        ),
                      ),

                      // feilds
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextFeild(
                          hint: "Name",
                          icon: Icons.person,
                          textController: name,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextFeild(
                          hint: "Email",
                          icon: Icons.email,
                          textController: email,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextFeild(
                          hint: "Passward",
                          obscureText: true,
                          icon: Icons.lock,
                          textController: password,
                        ),
                      ),

                      SizedBox(height: 20),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocConsumer<UserSignUpCubit, UserSignUpState>(
                            listener: (context, state) {
                              if (state is UserSignUpSuccess) {
                                snackBarMethod(context, "Sign up Success");
                                log(state.userModel.profileImageUrl.toString());
                              } else if (state is UserSignUpFailure) {
                                snackBarMethod(context, state.errorMsg);
                              }
                            },
                            builder: (context, state) {
                              return CustomButton(
                                child: state is UserSignUpLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        "Sign Up",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    BlocProvider.of<UserSignUpCubit>(
                                      context,
                                    ).signUp(
                                      email: email.text,
                                      password: password.text,
                                      name: name.text,
                                      image: selectedImage,
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
