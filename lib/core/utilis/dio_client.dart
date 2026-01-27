import 'package:dio/dio.dart';
import 'package:simple_face/core/utilis/cach_helper.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: "http://nmnm.runasp.net/", headers: {}),
  );

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final requiresToken = options.extra["requiresToken"] ?? true;

          if (requiresToken) {
            final user = CacheHelper.getUser();
            if (user != null && user.token.isNotEmpty) {
              options.headers["Authorization"] = "Bearer ${user.token}";
            }
          }

          handler.next(options);
        },
      ),
    );
  }
  Dio get dio => _dio;
}
