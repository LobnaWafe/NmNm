import 'package:dio/dio.dart';

abstract class Failure{
  final String errorMsg;

  Failure(this.errorMsg);
  
}

class ServerFailure extends Failure{
  ServerFailure(super.errorMsg);
  factory ServerFailure.dioException(DioException dioException){
    
   switch(dioException.type) {
     case DioExceptionType.connectionTimeout:

        return ServerFailure("Connection Time out");
        
     case DioExceptionType.sendTimeout:
       return ServerFailure("Send Time out");
     case DioExceptionType.receiveTimeout:
      return ServerFailure("Receiver Time out");
     case DioExceptionType.badCertificate:
       return ServerFailure("Bad Certificate");
     case DioExceptionType.badResponse:
      return ServerFailure.fromResponse(dioException.response?.data);

     case DioExceptionType.cancel:
       return ServerFailure("Request canceled");
     case DioExceptionType.connectionError:
       return ServerFailure("Connection Error");
     case DioExceptionType.unknown:
        if (dioException.message != null &&
            dioException.message!.contains("SocketException")) {
          return ServerFailure("No Internet Connection");
        }
        return ServerFailure("Unexpected Error, Please try again!");
   }
    
  }

 factory ServerFailure.fromResponse(dynamic response) {
  final message = ApiErrorParser.parse(response);
  return ServerFailure(message);
}

}
////////////////////////////////////

class ApiErrorParser {
  static String parse(dynamic error) {
    if (error == null) {
      return "Unexpected error occurred";
    }

    // 🔹 لو String مباشرة
    if (error is String) {
      return error;
    }

    // 🔹 لو Map
    if (error is Map<String, dynamic>) {
      // 1️⃣ detail
      if (error.containsKey("detail")) {
        return error["detail"].toString();
      }

      // 3️⃣ errors (small e)
      if (error.containsKey("errors")) {
        return _extractErrors(error["errors"]);
      }

      // 4️⃣ Errors (capital E)
      if (error.containsKey("Errors")) {
        return _extractErrors(error["Errors"]);
      }

      
      // 2️⃣ title
      if (error.containsKey("title")) {
        return error["title"].toString();
      }

      // fallback
      return error.values.first.toString();
    }

    return "Something went wrong";
  }

  static String _extractErrors(dynamic errors) {
    if (errors is Map) {
      final messages = <String>[];

      errors.forEach((key, value) {
        if (value is List) {
          messages.addAll(value.map((e) => e.toString()));
        } else {
          messages.add(value.toString());
        }
      });

      return messages.join("\n");
    }

    if (errors is List) {
      return errors.join("\n");
    }

    return errors.toString();
  }
}
