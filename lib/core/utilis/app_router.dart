import 'package:go_router/go_router.dart';
import 'package:simple_face/features/authentication/presentation/views/code_check_view.dart';
import 'package:simple_face/features/authentication/presentation/views/forget_password_view.dart';
import 'package:simple_face/features/authentication/presentation/views/login_view.dart';
import 'package:simple_face/features/authentication/presentation/views/reset_password_view.dart';
import 'package:simple_face/features/authentication/presentation/views/sign_up_view.dart';

abstract class AppRouter {
  static const String kLogin = "/";
  static const String kSignUp = "/SignUpView";
  static const String kForgetPassword = "/ForgetPasswordView";
  static const String kCodeCheck = "/CodeCheckView";
  static const String kResetPassword = "/RestPasswordView";
  static final router = GoRouter(
    routes: [
      GoRoute(path: kLogin, builder: (context, state) => LoginView()),
      GoRoute(path: kSignUp, builder: (context, state) => SignUpView()),
      GoRoute(
        path: kForgetPassword,
        builder: (context, state) => ForgetPasswordView(),
      ),

      GoRoute(
        path: kCodeCheck,
        builder: (context, state) => CodeCheckView(email: state.extra as String),
      ),


GoRoute(
  path: kResetPassword,
  builder: (context, state) {
    final args = state.extra as Map<String, String>;
    return ResetPasswordView(
      email: args['email']!,
      tempToken: args['tempToken']!,
    );
  },
),

    ],
  );
}
