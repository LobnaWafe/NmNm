import 'package:go_router/go_router.dart';
import 'package:simple_face/core/utilis/cach_helper.dart';
import 'package:simple_face/features/authentication/presentation/views/code_check_view.dart';
import 'package:simple_face/features/authentication/presentation/views/forget_password_view.dart';
import 'package:simple_face/features/authentication/presentation/views/login_view.dart';
import 'package:simple_face/features/authentication/presentation/views/reset_password_view.dart';
import 'package:simple_face/features/authentication/presentation/views/sign_up_view.dart';
import 'package:simple_face/features/home/data/models/users_system_mode.dart';
import 'package:simple_face/features/home/presentation/views/home_view.dart';
import 'package:simple_face/features/home/presentation/views/room_view.dart';

abstract class AppRouter {
  static const String kLogin = "/";
  static const String kSignUp = "/SignUpView";
  static const String kForgetPassword = "/ForgetPasswordView";
  static const String kCodeCheck = "/CodeCheckView";
  static const String kResetPassword = "/RestPasswordView";
  static const String kHomeView = "/HomeView";
  static const String kRoomView = "/RoomView";

  static final router = GoRouter(
    initialLocation: kLogin,
   redirect: (context, state) {
      final token = CacheHelper.getData(key: "token");
      
      // إحنا بنتدخل فقط لو المستخدم فاتح الصفحة الرئيسية (اللوجين) ومعاه توكن
      final isAtStart = state.matchedLocation == kLogin;

      if (isAtStart && token != null) {
        return kHomeView; // لو مسجل وديه الهوم فوراً
      }

      // في أي حالة تانية (رايح ساين أب، رايح ينسى الباسورد) سيبه يروح براحته
      return null; 
    },
    
    routes: [
      GoRoute(path: kLogin, builder: (context, state) => LoginView()),
      GoRoute(path: kSignUp, builder: (context, state) => SignUpView()),
      GoRoute(path: kHomeView, builder: (context, state) => HomeView()),
      GoRoute(
        path: kRoomView,
        builder: (context, state) =>
            RoomView(user: state.extra as UsersSystemMode),
      ),
      GoRoute(
        path: kForgetPassword,
        builder: (context, state) => ForgetPasswordView(),
      ),

      GoRoute(
        path: kCodeCheck,
        builder: (context, state) =>
            CodeCheckView(email: state.extra as String),
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
