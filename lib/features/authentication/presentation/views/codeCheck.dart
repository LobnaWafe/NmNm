import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:simple_face/core/utilis/Styles.dart';

import 'package:simple_face/core/utilis/app_router.dart';
import 'package:simple_face/features/authentication/presentation/view_model/forget_password/forget_password_cubit.dart';
import 'package:simple_face/features/authentication/presentation/view_model/verify_code/verify_code_cubit.dart';
import 'package:simple_face/features/authentication/presentation/widgets/custom_button.dart';
import 'package:simple_face/features/authentication/presentation/widgets/verify_text_feild.dart';


class Codecheck extends StatefulWidget {
  const Codecheck({super.key, required this.email});
  final String email;
  @override
  State<Codecheck> createState() => _CodecheckState();
}

class _CodecheckState extends State<Codecheck> {
  final List<TextEditingController> controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }

    for (final f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Verification", style: Styles.textStyle30),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter Verification Code",
                        style: Styles.textStyle20,
                      ),
    
                      SizedBox(height: 20),
    
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(4, (index) {
                          return SizedBox(
                            width: 60,
                            child: VerifyTextField(
                              controllers: controllers,
                              focusNodes: focusNodes,
                              index: index,
                            ),
                          );
                        }),
                      ),
    
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "If you don't receieve a code ",
                              style: Styles.textStyle12.copyWith(
                                color: const Color.fromARGB(
                                  255,
                                  149,
                                  150,
                                  150,
                                ),
                              ),
                            ),
    
                          GestureDetector(
                                  onTap: () {
                                    context
                                        .read<ForgetPasswordCubit>()
                                        .forgetPassword(email: widget.email);
                                  },
                                  child: Text(
                                    "Resend",
                                    style: Styles.textStyle12,
                                  ),
                                )
                         
                          ],
                        ),
                      ),
    
                      BlocConsumer<VerifyCodeCubit, VerifyCodeState>(
                        listener: (context, state) {
                          if (state is VerifyCodeSuccess) {
                            //nav
                            GoRouter.of(context).push(
                              AppRouter.kResetPassword,
                              extra: {
                                "email": widget.email,
                                "tempToken": state.tempToken,
                              },
                            );
                          } else if (state is VerifyCodeFailure) {
                            snackBarMethod(context, state.errorMsg);
                          }
                        },
                        builder: (context, state) {
                          return CustomButton(
                            onPressed: () {
                              final code = controllers
                                  .map((e) => e.text)
                                  .join();
                              if (code.length == 4) {
                                debugPrint("OTP Code: $code");
    
                                //API Call
                                BlocProvider.of<VerifyCodeCubit>(
                                  context,
                                ).verifyCode(email: widget.email, code: code);
                              } else {
                                debugPrint("Incomplete code");
                              }
                            },
                            child: state is VerifyCodeLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Send",
                                    style: TextStyle(color: Colors.white),
                                  ),
                          );
                        },
                      ),
                    ],
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
