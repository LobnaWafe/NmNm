import 'package:dio/dio.dart';
import 'package:simple_face/core/utilis/cach_helper.dart';

// class ApiInterceptor extends Interceptor{
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
//     // options.headers['token'] = sl<CacheHelper>().getData(key: 'token') != null
//     //     ? 'FOODAPI ${sl<CacheHelper>().getData(key: 'token')}'
//     //     : null;
    
//     super.onRequest(options, handler);
//   }
// }

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) {

    final token = CacheHelper.getData(key: 'token');

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }
}